module ConciseLogging
  class Railtie < Rails::Railtie
    unless Rails.env.development?
      initializer "railtie.concise_logging" do |app|
        app.middleware.use ConciseLogging::LogMiddleware
      end

      ConciseLogging::LogSubscriber.attach_to :action_controller
    end
  end
end
