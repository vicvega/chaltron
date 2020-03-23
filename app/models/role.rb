class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :role_assignments
  has_many :users, through: :role_assignments
end
