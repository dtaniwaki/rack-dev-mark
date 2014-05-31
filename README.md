# rack-dev-mark

[![Gem Version](https://badge.fury.io/rb/rack-dev-mark.png)](https://rubygems.org/gems/rack-dev-mark) [![Build Status](https://secure.travis-ci.org/dtaniwaki/rack-dev-mark.png?branch=master)](http://travis-ci.org/dtaniwaki/rack-dev-mark) [![Coverage Status](https://coveralls.io/repos/dtaniwaki/rack-dev-mark/badge.png?branch=master)](https://coveralls.io/r/dtaniwaki/rack-dev-mark?branch=master)

Differenciate development environment from production.

## Screenshot

### Development

![screenshot development](screenshot-development.png)

### Production

![screenshot production](screenshot-production.png)

## Installation

Add the rack-dev-mark gem to your Gemfile.

```ruby
gem "rack-dev-mark"
```

And run `bundle install`. The rest of the installation depends on
whether the asset pipeline is being used.

Then, initialize planbcd.

## Usage

### For your Rack app

```ruby:config.ru
require 'rack/dev-mark'
use Rack::DevMark::Middleware
run MyApp
```

### For your Rails app

This gem inserts rack middleware for all the environment except production automatically.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

### Use custom theme

Define a sub class of `Rack::DevMark::Theme::Base` somewhere in your app.

```ruby
require 'rack/dev-mark/theme/base'

class NewTheme < Rack::DevMark::Theme::Base
  def insert_into(html, env)
    # Do something for your theme
    html
  end
end
```

Then, insert it in your app.

For your Rack app

```ruby
use Rack::DevMark::Middleware, Rack::DevMark::Theme::NewTheme.new
```

For your Rails app

```ruby:config/application.rb
module MyApp
  class Application < Rails::Application
    config.middleware.delete Rack::DevMark::Middleware
    config.middleware.use Rack::DevMark::Middleware, NewTheme.new
  end
end
```

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.
