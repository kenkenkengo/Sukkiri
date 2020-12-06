module GroupsHelper
  def admin_user?(group)
    current_user == group.admin_user
  end
end