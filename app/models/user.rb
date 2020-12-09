class User < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :email, presence: true, length: {maximum: 50}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    has_secure_password validations: true
    validates :password, length: {minimum: 6}
end
