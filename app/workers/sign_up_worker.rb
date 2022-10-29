class SignUpWorker
  include Sidekiq::Worker

  def perform(user_id, sign_up_role)
    user = User.find_by(id: user_id)
    user.sign_up_role = sign_up_role

    SignUpService.call(user:)
  end
end
