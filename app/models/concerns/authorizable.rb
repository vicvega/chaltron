module Authorizable
  extend ActiveSupport::Concern

  included do
    has_many :role_assignments
    has_many :roles, through: :role_assignments
  end

  def has_role?(role)
    roles.any? { |r| r.name.underscore == role.to_s }
  end
end
