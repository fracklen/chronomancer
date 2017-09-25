class Authorizor
  def initialize(user)
    @user = user
  end

  def admin?
    return @user.admin?
  end
end
