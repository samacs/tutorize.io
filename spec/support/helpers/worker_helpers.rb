module WorkerHelpers
  def perform_enqueued_workers
    yield if block_given?

    Sidekiq::Worker.drain_all
  end
end

RSpec.configure do |config|
  config.include WorkerHelpers
end
