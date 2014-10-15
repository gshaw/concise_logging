module ConciseLogging
  class Railtie < Rails::Railtie
    initializer "railtie.configure_rails_initialization" do |app|
      app.middleware.use ConciseLogging::LogMiddleware
    end

    ConciseLogging::LogSubscriber.attach_to :action_controller
  end
end
