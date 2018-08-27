module Authorizable
  def roles=(roles)
    self.roles_mask = (roles & Chaltron.roles).map { |r| 2**Chaltron.roles.index(r) }.inject(:+)
  end

  def roles
    Chaltron.roles.reject do |r|
      ((roles_mask || 0) & 2**Chaltron.roles.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end
end
