# frozen_string_literal: true

class User < ApplicationRecord
  has_many :locations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
