require 'active_support'
module ConciseLogging
  class LogSubscriber < ActiveSupport::LogSubscriber
    INTERNAL_PARAMS = %w(controller action format _method only_path)

    def redirect_to(event)
      Thread.current[:logged_location] = event.payload[:location]
    end

    def process_action(event)
      payload = event.payload
      param_method = payload[:params]["_method"]
      method = param_method ? param_method.upcase : payload[:method]
      status, exception_details = compute_status(payload)
      path = payload[:path].to_s.gsub(/\?.*/, "")
      params = payload[:params].except(*INTERNAL_PARAMS)

      ip = Thread.current[:logged_ip]
      location = Thread.current[:logged_location]
      Thread.current[:logged_location] = nil

      app = payload[:view_runtime].to_i
      db = payload[:db_runtime].to_i

      message = format(
        "%{method} %{status} %{ip} %{path}",
        ip: format("%-15s", ip),
        method: format_method(format("%-6s", method)),
        status: format_status(status),
        path: path
      )
      message << " redirect_to=#{location}" if location.present?
      message << " parameters=#{params}" if params.present?
      message << " #{color(exception_details, RED)}" if exception_details.present?
      message << " (app:#{app}ms db:#{db}ms)"

      logger.warn message
    end

    def compute_status(payload)
      details = nil
      status = payload[:status]
      if status.nil? && payload[:exception].present?
        exception_class_name = payload[:exception].first
        status = ActionDispatch::ExceptionWrapper.status_code_for_exception(exception_class_name)

        if payload[:exception].respond_to?(:uniq)
          details = payload[:exception].uniq.join(" ")
        end
      end
      [status, details]
    end

    def format_method(method)
      if method.strip == "GET"
        method
      else
        color(method, CYAN)
      end
    end

    def format_status(status)
      status = status.to_i
      if status >= 400
        color(status, RED)
      elsif status >= 300
        color(status, YELLOW)
      else
        color(status, GREEN)
      end
    end
  end
end
