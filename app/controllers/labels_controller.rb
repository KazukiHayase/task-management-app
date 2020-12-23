class LabelsController < ApplicationController
    def index
        @label = Label.new
        @labels = Label.all
    end

    def destroy
        label = Label.find(params[:id])
        label.destroy
        flash[:success] = "ラベルを削除しました！"
        redirect_to labels_path
    end
    
    private
        def label_params
            params.require(:label).permit(:name)
        end
end
