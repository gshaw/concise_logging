module ConciseLogging
  module ControllerRuntime
    extend ActiveSupport::Concern

    def append_info_to_payload(payload)
      super
      payload[:response_body] = response.body
    end

  end
end