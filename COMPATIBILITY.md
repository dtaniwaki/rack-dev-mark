# Compatibility with Other Middlewares

## Rack::Deflater

Some people ask rack-dev-mark does not work with `Rack::Delfater`. Those who ask this question typically insert `Rack::Deflater` by `config.middleware.use Rack::Deflater`. To deflate all the response including the error pages, you need to put the middleware before `ActionDispatch::ShowExceptions`. So the order of those 3 middlewares including `rack-dev-mark` looks like below.

```ruby
use Rack::Deflater
use Rack::DevMark::Middleware
use ActionDispatch::ShowExceptions
```

To make the order above, you can have the following settings for `Rack::Deflater`.

```ruby
module MyApp
  class Application < Rails::Application
    config.middleware.insert_before ActionDispatch::ShowExceptions, Rack::Deflater
  end
end
```

Of course, you can stick the `config.middleware.use Rack::Deflater` by the following settings for `rack-dev-mark`.

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.insert_after Rack::Deflater
  end
end
```

