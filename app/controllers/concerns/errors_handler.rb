module ErrorsHandler
    extend ActiveSupport::Concern

    def routing_error
        raise ActionController::RoutingError, params[:path]
    end

    included do
        rescue_from ActionController::RoutingError, with: :render_404
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
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
end
