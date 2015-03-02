module ConciseLogging
  class Railtie < Rails::Railtie
    unless Rails.env.development?
      initializer "railtie.concise_logging" do |app|
        app.middleware.use ConciseLogging::LogMiddleware
      end

      ConciseLogging::LogSubscriber.attach_to :action_controller

      config.after_initialize do
        ActiveSupport.on_load(:action_controller) do
          # Lazily load action_controller methods
          #
          require 'concise_logging/controller_runtime'

          include ConciseLogging::ControllerRuntime if ConciseLogging.configuration.log_response
        end
      end
    end
  end
end
