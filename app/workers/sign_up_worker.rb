class SignUpWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)

    SignUpService.call(user:)
  end
end
