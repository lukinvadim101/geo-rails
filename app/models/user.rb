# frozen_string_literal: true

class User < ApplicationRecord
  has_many :locations, dependent: :destroy

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist
end
