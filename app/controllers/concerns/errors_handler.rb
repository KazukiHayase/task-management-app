module ErrorsHandler
    extend ActiveSupport::Concern

    def routing_error
        raise ActionController::RoutingError, params[:path]
    end

    included do
        rescue_from StandardError, with: :render_500
        rescue_from ApplicationError::NotPermittedError, with: :redirect_tasks_or_login
        rescue_from ActionController::RoutingError, with: :render_404
        rescue_from ActiveRecord::RecordNotFound, with: :render_404
    end

    private

    def render_404(e = nil)
        logger.info "Rendering 404 with exception: #{e.message}" if e

        if request.format.to_sym == :json
            render json: { error: '404 error' }, status: :not_found
        else
            render 'errors/404', status: :not_found
        end
    end

    def render_500(e = nil)
        logger.error "Rendering 500 with exception: #{e.message}" if e
        
        if request.format.to_sym == :json
            render json: { error: '500 error' }, status: :internal_server_error
        else
            render 'errors/500', status: :internal_server_error
        end
    end

    def redirect_tasks_or_login(e = nil)
        logger.info "Redirecting with exception: #{e.message}" if e

        flash[:danger] = "閲覧権限がありません"
        redirect_to tasks_path
    end
end
