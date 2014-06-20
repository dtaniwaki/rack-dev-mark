# rack-dev-mark

[![Gem Version](https://badge.fury.io/rb/rack-dev-mark.svg)](http://badge.fury.io/rb/rack-dev-mark) [![Build Status](https://secure.travis-ci.org/dtaniwaki/rack-dev-mark.png?branch=master)](http://travis-ci.org/dtaniwaki/rack-dev-mark) [![Coverage Status](https://coveralls.io/repos/dtaniwaki/rack-dev-mark/badge.png?branch=master)](https://coveralls.io/r/dtaniwaki/rack-dev-mark?branch=master) [![Code Climate](https://codeclimate.com/github/dtaniwaki/rack-dev-mark.png)](https://codeclimate.com/github/dtaniwaki/rack-dev-mark)

Differentiate development environment from production.
You can choose [themes](lib/rack/dev-mark/theme/README.md) to differentiate the page.

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

```ruby
require 'rack/dev-mark'
use Rack::DevMark::Middleware
run MyApp
```

### For your Rails app

In `config/environments/development.rb`

```ruby
MyApp::Application.configure do
  config.rack_dev_mark.enable = true
end
```

Or
In `config/application.rb`

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.enable = !Rails.env.production?
  end
end
```

Or
Alternatively, use generator

```bash
bundle exec rails g rack-dev-mark:install
```

The middleware sets [title](lib/rack/dev-mark/theme/title.rb) and [github_fork_ribbon](lib/rack/dev-mark/theme/github_fork_ribbon.rb) themes as default.

#### Exclude Multiple Environments in Rails

Show the dev mark except env1, env2, env3.

In `config/application.rb`

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.enable = !%w(env1 env2 env3).include?(Rails.env)
  end
end
```

## Custom Theme

Define a sub class of `Rack::DevMark::Theme::Base` somewhere in your app.

```ruby
require 'rack/dev-mark/theme/base'

class NewTheme < Rack::DevMark::Theme::Base
  def insert_into(html)
    # Do something for your theme
    html
  end
end

class AnotherTheme < Rack::DevMark::Theme::Base
  def insert_into(html)
    # Do something for your theme
    html
  end
end
```

Then, insert it in your app.

### For your Rack app

```ruby
use Rack::DevMark::Middleware, [NewTheme.new, AnotherTheme.new]
```

### For your Rails app

In `config/application.rb`

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.custom_theme = [NewTheme.new, AnotherTheme.new]
  end
end
```

You can add any combination of themes.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.
