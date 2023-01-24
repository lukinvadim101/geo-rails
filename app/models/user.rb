# frozen_string_literal: true

class User < ApplicationRecord
  # has has_secure_password
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :locations, dependent: :destroy
  has_many :jwt_denylists, dependent: :destroy

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: self
end
