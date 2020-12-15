class User < ApplicationRecord
    # バリデーション
    VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 50}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    validates :password, length: {minimum: 6}
    
    # アソシエーション
    has_many :tasks, dependent: :destroy

    # その他
    has_secure_password validations: true
end
