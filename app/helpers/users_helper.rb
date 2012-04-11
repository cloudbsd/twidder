module UsersHelper
  def is_current_user?(user)
    return false unless user_signed_in?
    return current_user == user
  end

  def is_admin_user?(user)
    return false unless user_signed_in?
    return false
  # return user.admin?
  end
end
