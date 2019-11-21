# This policy has the authorization conditions for every task endpoint
class TaskPolicy < ApplicationPolicy
  def index?
    user.id == record.id || user.admin? || user.supervisor?
  end

  def create?
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
