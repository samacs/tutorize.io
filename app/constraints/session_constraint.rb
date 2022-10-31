class SessionConstraint
  def initialize(&block)
    @block = block || ->(_) { false }
  end

  def matches?(request)
    user_id = request.session[:user_id]
    user = User.preload(:roles).find_by(id: user_id)
    user.present? && @block.call(user)
  end
end
