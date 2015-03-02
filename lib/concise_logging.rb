require "concise_logging/version"
require "concise_logging/log_middleware"
require "concise_logging/log_subscriber"
require "concise_logging/configuration"
require "concise_logging/railtie" if defined? Rails

module ConciseLogging
  class << self
    # Call this method to modify defaults in your initializers.
    #
    # @example
    #   ConciseLogging.configure do |config|
    #     config.log_response = true
    #   end
    def configure
      yield(configuration)
    end

    # The configuration object.
    # @see ConciseLogging.configure
    def configuration
      @configuration ||= Configuration.new
    end
  end
end
