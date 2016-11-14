require "minitest/autorun"
require "concise_logging/log_subscriber"

class LoaderTest < Minitest::Test
  def test_attach_to_log_subscriber
    log_subscriber = ConciseLogging::LogSubscriber.new
    ActiveSupport::LogSubscriber.attach_to(:my_log_subscriber, log_subscriber)
    assert true
  end
end
