class Label < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    
    has_many :labelings, dependent: :destroy
    has_many :tasks, through: :labelings
end
