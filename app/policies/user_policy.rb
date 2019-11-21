# This policy has the authorization conditions for every user endpoint
class UserPolicy < ApplicationPolicy
  def index?
    user.admin? || user.supervisor?
  end

  def show?
    user.id == record.id || user.admin? || user.supervisor?
  end

  def update?
    user.id == record.id || user.admin? || user.supervisor?
  end

  def destroy?
    user.id == record.id || user.admin? || user.supervisor?
  end
end
