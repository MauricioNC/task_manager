class User < ApplicationRecord
  include ActiveModel::Validations

  has_secure_password validations: false

  has_many :tasks

  validates :name, presence: {message: "Name can't be blank" }
  
  validates :username, presence: { message: "Username can't be blank"}
  validates :username, uniqueness: true, if: -> { !username.blank? }
  
  validates :email, presence: { message: "Email can't be blank"}
  validates :email, uniqueness: true, email: true, if: -> { !email.blank? }

  validates :password, presence: { message: "Password can't be blank"}
  validates :password, confirmation: true, length: { minimum: 8 }, password: true, if: -> { !password.blank? }
  
  validates :password_confirmation, presence: { message: "Password confirmation doesn't match"}
end
