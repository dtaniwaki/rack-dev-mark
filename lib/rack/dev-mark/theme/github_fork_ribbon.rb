# Thanks to https://github.com/simonwhitaker/github-fork-ribbon-css
require 'rack/dev-mark/theme/base'

module Rack
  module DevMark
    module Theme
      class GithubForkRibbon < Base
        def insert_into(html, env, params = {})
          revision = params[:revision]
          timestamp = params[:timestamp]

          position = @options[:position] || 'left'
          color = @options[:color] || 'red'
          fixed = @options[:fixed] ? ' fixed' : ''
          title = []
          title << revision if revision.to_s != ''
          title << timestamp if timestamp.to_s != ''
          title = title.join("&#10;")

          s = <<-EOS
#{stylesheet_link_tag "github-fork-ribbon-css/gh-fork-ribbon.css"}
<!--[if lt IE 9]>
#{stylesheet_link_tag "github-fork-ribbon-css/gh-fork-ribbon.ie.css"}
<![endif]-->
<div class="github-fork-ribbon-wrapper #{position}#{fixed}" onClick="this.style.display='none'" title="#{title}"><div class="github-fork-ribbon #{color}"><span class="github-fork-ribbon-text">#{env}</span></div></div>
          EOS

          html.sub %r{(<body[^>]*>)}i, "\\1#{s.strip}"
        end
      end
    end
  end
end
