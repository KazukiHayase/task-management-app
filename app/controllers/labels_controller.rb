class LabelsController < ApplicationController
    def index
        @label = Label.new
        @labels = Label.all
    end

    def create
        @label = Label.new(label_params)
        @labels = Label.all

        if @label.save
            flash[:success] = "ラベルを作成しました！"
            redirect_to labels_path
        else
            flash[:danger] = "ラベルの作成に失敗しました"
            render "index"
        end
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
