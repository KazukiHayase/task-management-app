class Task < ApplicationRecord
    belongs_to :user
    validates :name, presence: true, length: {maximum: 50}
    validates :content, presence: true, length: {maximum:200}
    validate  :date_not_before_today

    enum status: {"not_started": 1, "doing": 2, "done": 3}
    enum priority: {"low": 1, "middle": 2, "high": 3}

    has_many :labelings
    has_many :labels, through: :labelings

    scope :search, lambda { |search_params|
        user_is(search_params[:user])
            .name_like(search_params[:keyword])
            .status_is(search_params[:status])
    }
    scope :sorted_by, lambda { |sort_params|
        user_is(sort_params[:user])
            .order("#{sort_params[:column]} #{sort_params[:direction]}")
    }
    scope :recent, lambda { |user|
        user_is(user)
            .order(created_at: :desc)
    }
    scope :name_like, -> (keyword) { where("name LIKE ?", "%#{keyword}%") if keyword.present?}
    scope :status_is, -> (status) { where(status: status) if status.present?}
    scope :user_is, -> (user) { where(user_id: user) if user.present? }
    scope :has_label, -> (labels) { eager_load(:labels).where(labels: {id: labels}) }

    private
    
    def date_not_before_today
        if deadline.present? && deadline < Date.today
            errors.add(:deadline, "は今日以降を選択してください")
        end
    end
end
