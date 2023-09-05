# frozen_string_literal: true

class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users

  validates :name, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true, presence: true

  has_secure_password
end
