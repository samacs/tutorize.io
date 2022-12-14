class ServiceBase
  extend LightService::Organizer

  class << self
    def call(context)
      with(context).reduce(actions)
    end

    private

    def actions
      raise 'Please override this method and include your service actions'
    end
  end
end
