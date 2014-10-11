# ConciseLogging

Alternate logging for Rails production servers

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'concise_logging'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install concise_logging

## Usage

Add this to your `config/production.rb`.  Configure tagging as per your desires.

````ruby
config.middleware.use "ConciseLogging::LogMiddleware"
ConciseLogging::LogSubscriber.attach_to :action_controller

config.log_level = :warn
config.log_tags = ["cv-#{Rails.env[0]}"]
config.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(File.join(Rails.root, "log", "#{Rails.env}.log")))
````

## Contributing

1. Fork it ( https://github.com/[my-github-username]/concise_logging/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
