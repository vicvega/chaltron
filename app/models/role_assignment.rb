class RoleAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :assigned_by, class_name: 'User', optional: true
end
