module ConciseLogging
  class Configuration
    attr_accessor :log_response

    def initializer
      @log_response = false
    end
  end
end