module GroupsHelper
  def admin_user?(group)
    current_user == group.admin_user
  end

  def belonging?(group)
    current_user.groups.find_by(id: group.id)
  end
end
