module UsersHelper
  
  # Returns the joined first and last_name for a User
  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end
  
end
