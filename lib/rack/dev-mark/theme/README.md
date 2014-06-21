# Theme

You can set options when you add the themes into your app. Otherwise, just put the symbol of the theme filename.

### For your Rack app

```ruby
use Rack::DevMark::Middleware, [:title, Rack::DevMark::Theme::GithubForkRibbon.new(position: 'right')]
```

### For your Rails app

In config/application.rb

```ruby
module MyApp
  class Application < Rails::Application
    config.rack_dev_mark.custom_theme = [:title, Rack::DevMark::Theme::GithubForkRibbon.new(position: 'right')]
  end
end
```

## title

Just add the environment into the page title.

e.g.

`My Homepage` on development env will be `(development) My Homepage`

### options

`type`: `prefix` (default) or `postfix`

`upcase`: `true` or `false` (default)

## github-fork-ribbon

["Fork Me on GitHub" like ribbon](https://github.com/simonwhitaker/github-fork-ribbon-css) originally created by [simonwhitaker](https://github.com/simonwhitaker)

![github-fork-ribbon](screenshots/github_fork_ribbon.png)

### options

`position`: left (default), right, left-bottom, right-bottom

`color`: red (default), orange, green, black

`fixed`: `true` or `false`(default)
