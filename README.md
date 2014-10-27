# ConciseLogging

Concise request logging for Rails production

![screenshot](https://github.com/gshaw/concise_logging/raw/master/img/screenshot.png)

Logs a concise single line for each request at `:warn` level.  This allows
logging requests without all the extra logging that `:info` level outputs.

Not suitable for development but ideal for production settings where each
request and associated parameters is logged.

Inspired by a [blog post on RubyJunky.com][1].

Special thanks to [Zohreh Jabbari](https://github.com/zohrehj) for doing the
initial coding and proof of concept.

[1]: http://rubyjunky.com/cleaning-up-rails-4-production-logging.html

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
We use tagging to indicate application with a 2 letter code and environment with
a single letter (e.g., p = production, s = staging).

```ruby
# Configure logger to log warn and above
config.log_level = :warn
config.log_tags = ["cv-#{Rails.env[0]}"]
config.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(File.join(Rails.root, "log", "#{Rails.env}.log")))
```

If you want to try the logger in development than you have to manually add the
middleware and attach the log subscriber by adding these lines in your
`config/development.rb` file.  These lines are not needed for production.

```ruby
Rails.application.middleware.use ConciseLogging::LogMiddleware
ConciseLogging::LogSubscriber.attach_to :action_controller
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/concise_logging/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
