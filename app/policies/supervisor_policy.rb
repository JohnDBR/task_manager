# This policy has the authorization conditions for every supervisor endpoint
class SupervisorPolicy < ApplicationPolicy
  def index?
    user.id == record.id || user.admin? || user.supervisor?
  end

  def create?
    user.supervisor? && record.supervised?
  end

  def destroy?
    user.admin? || (user.supervisor? && record.supervisor_id == user.id)
  end
end
