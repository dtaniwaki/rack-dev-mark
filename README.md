# rack-dev-mark

[![Gem Version][gem-image]][gem-link]
[![Download][download-image]][download-link]
[![Dependency Status][deps-image]][deps-link]
[![Build Status][build-image]][build-link]
[![Coverage Status][cov-image]][cov-link]
[![Code Climate][gpa-image]][gpa-link]

Differentiate development environment from production. You can choose [themes](THEME.md) to differentiate the page.

[The running sample](http://rack-dev-mark.dtaniwaki.com/) is available.

You can also try this gem on Heroku.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/dtaniwaki/rack-dev-mark-sample-app)

## Screenshot

![screenshot development](misc/screenshot.gif)

### On Development Env

![screenshot development](misc/screenshot-development.png)

### On Production Env

![screenshot production](misc/screenshot-production.png)

## Installation

Add the rack-dev-mark gem to your Gemfile.

```ruby
gem "rack-dev-mark"
```

And run `bundle install`.

### For Rack App

```ruby
require 'rack/dev-mark'
use Rack::DevMark::Middleware
run MyApp
```

#### Middleman

Add the settings in `config.rb`.

```ruby
require 'rack/dev-mark'
Rack::DevMark.env = "Your Env"
use Rack::DevMark::Middleware
```

### For Rails App

In `config/environments/development.rb`

```ruby
Rails.application.configure do
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
bundle exec rails g rack:dev-mark:install
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

#### Rails on Heroku

Since Heroku [uses production env for staging](https://devcenter.heroku.com/articles/multiple-environments). You can't use the settings above. However, the gem provide an easier way to set it up on Heroku. Just set the environment variable on the environment in which you want to show the mark.

```bash
heroku config:set RACK_DEV_MARK_ENV=staging
```

That's it!

#### Custom Rack Middleware Order

`rack-dev-mark` should be inserted before `ActionDispatch::ShowExceptions` becase we want to show the dev mark on the error pages as well. However, it does not work well if it's inserted by incorrect order with some other rack middlewares. So, it provides the setting of inserted place.

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.insert_before SomeOtherMiddleware
  end
end
```

`config.rack_dev_mark.insert_after` is also available to insert `rack-dev-mark` after a middleware.

[Here](COMPATIBILITY.md) is the compatibility list which many people often ask.

#### Custom env string

Set the custom env string maually.

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.env = 'foo'
  end
end
```

#### Temporarily disable the dev mark

`skip_rack_dev_mark` controller helper works like `around_filter`.

```ruby
class FooController < ApplicationController
  skip_rack_dev_mark only: [:iframe]

  def index
    # Do something
  end

  def iframe
    # Do something
  end
end
```

In this case, only `index` action will insert the dev mark.

## I18n Support

Get i18n string with rack_dev_mark locale strings.

e.g. In `config/locale/rack_dev_mark.ja.yml`

```
ja:
  rack_dev_mark:
    development: '開発中'
    staging: 'ステージング'
```

Then, you will get translated string on the pages!

## Custom Theme

Although the default themes are `title` and `github_fork_ribbon`, you can create your own themes inheriting `Rack::DevMark::Theme::Base`.

```ruby
require 'rack/dev-mark/theme/base'

class NewTheme < Rack::DevMark::Theme::Base
  def insert_into(html, env, params = {})
    # Do something for your theme
    html
  end
end

class AnotherTheme < Rack::DevMark::Theme::Base
  def insert_into(html, env, params = {})
    # Do something for your theme
    html
  end
end
```

Then, insert them in your app.

### For Rack App

```ruby
use Rack::DevMark::Middleware, [NewTheme.new, AnotherTheme.new]
```

### For Rails App

In `config/application.rb`

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.theme = [NewTheme.new, AnotherTheme.new]
  end
end
```

You can add any combination of themes. See more about [themes](THEME.md).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.




[gem-image]:   https://badge.fury.io/rb/rack-dev-mark.svg
[gem-link]:    http://badge.fury.io/rb/rack-dev-mark
[download-image]:https://img.shields.io/gem/dt/rack-dev-mark.svg
[download-link]:https://rubygems.org/gems/rack-dev-mark
[build-image]: https://secure.travis-ci.org/dtaniwaki/rack-dev-mark.svg
[build-link]:  http://travis-ci.org/dtaniwaki/rack-dev-mark
[deps-image]:  https://gemnasium.com/dtaniwaki/rack-dev-mark.svg
[deps-link]:   https://gemnasium.com/dtaniwaki/rack-dev-mark
[cov-image]:   https://coveralls.io/repos/dtaniwaki/rack-dev-mark/badge.png
[cov-link]:    https://coveralls.io/r/dtaniwaki/rack-dev-mark
[gpa-image]:   https://codeclimate.com/github/dtaniwaki/rack-dev-mark.svg
[gpa-link]:    https://codeclimate.com/github/dtaniwaki/rack-dev-mark

