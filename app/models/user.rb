class User < ApplicationRecord
  has_many :locations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
