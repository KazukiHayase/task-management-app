class User < ApplicationRecord
    # バリデーション
    VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 50}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    validates :password, length: {minimum: 6}, allow_nil: true
    
    # アソシエーション
    has_many :tasks, dependent: :destroy

    # コールバック
    before_destroy :must_have_at_least_one_admin_user

    # その他
    has_secure_password validations: true
    attr_accessor :remember_token
    enum admin: {"admin": true, "not_admin": false}

    def self.new_token
        SecureRandom.urlsafe_base64
    end

    def self.digest(token)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engne::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(token, const: cost)
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
    
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_token).is_password?(remember_token)
    end

    def must_have_at_least_one_admin_user
        throw :abort unless User.where(admin: true).count > 1
    end
end
