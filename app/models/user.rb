class User < ApplicationRecord
  require "securerandom"
  has_secure_password
  has_one_attached :avatar

  has_many :posts
  has_many :comments

  validates :name, presence: true, length: { minimum: 5, maximum: 50, message: "name must be more than 5 chars and less than 50 chars." }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: " Invalid email address." }
  validates :password, presence: true, length: { minimum: 8 }
  validates_confirmation_of :password
end
