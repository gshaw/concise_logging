require 'spec_helper'

describe ConciseLogging::LogSubscriber do
  it 'does not crash' do
    @log_subscriber = described_class.new
    ActiveSupport::LogSubscriber.attach_to :my_log_subscriber, @log_subscriber
  end

end
