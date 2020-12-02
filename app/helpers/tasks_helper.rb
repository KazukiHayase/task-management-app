module TasksHelper
    def sort_tasks(sort_number)
        case sort_number
        when 1
            Task.all.order(deadline: :ASC)
        when 2
            Task.all.order(deadline: :DESC)
        end
    end
end
