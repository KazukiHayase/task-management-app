module TasksHelper
    def sort_tasks(sort_number)
        case sort_number
        when 1
            Task.all.order(deadline: :ASC)
        when 2
            Task.all.order(deadline: :DESC)
        end
    end

    def status(status_number)
        case status_number
        when 1
            "未着手"
        when 2
            "着手中"
        when 3
            "完了"
        end
    end
    
end
