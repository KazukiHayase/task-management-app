class Task < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    validates :content, presence: :true, length: {maximum:200}
    validate  :date_not_before_today

    private
    
    def date_not_before_today
        if deadline.present? && deadline < Date.today
            errors.add(:deadline, "は今日以降を選択してください")
        end
    end
end
