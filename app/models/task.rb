class Task < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    validates :content, presence: :true, length: {maximum:200}
    validate  :date_not_before_today

    enum status: {"not_started": 1, "doing": 2, "done": 3}

    scope :search, lambda { |search_params|
        name_like(search_params[:keyword])
            .status_is(search_params[:status])
    }
    scope :name_like, -> (keyword) { where("name LIKE ?", "%#{keyword}%") if keyword.present?}
    scope :status_is, -> (status) { where(status: status) if status.present?}

    private
    
    def date_not_before_today
        if deadline.present? && deadline < Date.today
            errors.add(:deadline, "は今日以降を選択してください")
        end
    end
end
