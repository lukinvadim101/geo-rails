# frozen_string_literal: true

class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist
  has_one :user

  self.table_name = 'jwt_denylist'
end
