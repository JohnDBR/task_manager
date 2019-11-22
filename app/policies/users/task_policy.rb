# This policy has the authorization conditions for every task endpoint
class Users::TaskPolicy < ApplicationPolicy
  def index?
    user.id == record.id || user.admin? || user.supervisor?
  end

  def create?
    user.id == record.user_id || user.admin? || user.supervisor?
  end

  def show?
    user.id == record.user_id || user.admin? || user.supervisor?
  end

  def update?
    user.id == record.user_id || user.admin? || user.supervisor?
  end

  def destroy?
    user.id == record.user_id || user.admin? || user.supervisor?
  end
end
