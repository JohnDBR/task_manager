# This policy has the authorization conditions for every task endpoint of an user that relates to category
class Users::Tasks::CategoryPolicy < ApplicationPolicy
  def index?
    user.id == record.id || user.admin? || user.supervisor?
  end
end
