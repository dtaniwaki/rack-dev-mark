# rack-dev-mark

[![Gem Version](https://badge.fury.io/rb/rack-dev-mark.svg)](http://badge.fury.io/rb/rack-dev-mark) [![Build Status](https://secure.travis-ci.org/dtaniwaki/rack-dev-mark.png?branch=master)](http://travis-ci.org/dtaniwaki/rack-dev-mark) [![Coverage Status](https://coveralls.io/repos/dtaniwaki/rack-dev-mark/badge.png?branch=master)](https://coveralls.io/r/dtaniwaki/rack-dev-mark?branch=master)

Differentiate development environment from production.

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

And run `bundle install`.

### For your Rack app

```ruby:config.ru
require 'rack/dev-mark'
use Rack::DevMark::Middleware
run MyApp
```

### For your Rails app

This gem inserts rack middleware for all the environment except production automatically.

## Custom Theme

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

### For your Rack app

```ruby
use Rack::DevMark::Middleware, NewTheme.new
```

### For your Rails app

```ruby:config/application.rb
Rack::DevMark.theme = NewTheme.new
```

## Production Environment

You can change production environment name.

### For your Rails app

```ruby:config/application.rb
Rack::DevMark.production_env = ['demo', 'production']
```

Then the mark won't show up on demo and production environments.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.
