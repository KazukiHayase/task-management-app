class LabelsController < ApplicationController
    def index
        @label = Label.new
        @labels = Label.all
    end
    
    private
        def label_params
            params.require(:label).permit(:name)
        end
end
