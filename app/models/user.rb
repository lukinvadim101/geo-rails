class User < ApplicationRecord
  has_many :private_locations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
