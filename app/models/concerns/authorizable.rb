module Authorizable
  extend ActiveSupport::Concern

  included do
    has_many :role_assignments
    has_many :roles, through: :role_assignments
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role.to_sym }
  end
end
