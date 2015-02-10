module ConciseLogging
  class LogMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)
      Thread.current[:logged_ip] = request.env['HTTP_X_REAL_IP'] || request.ip
      @app.call(env)
    ensure
      Thread.current[:logged_ip] = nil
    end
  end
end
