module TasksHelper
    def sort_column(column)
        Task.column_names.include?(column) ? column : "created_at"
    end

    def sort_direction(direction)
        %w[asc desc].include?(direction) ? direction : "desc"
    end
end
