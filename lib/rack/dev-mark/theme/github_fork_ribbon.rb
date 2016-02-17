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

          style_tag_str = <<-EOS
#{stylesheet_link_tag "github-fork-ribbon-css/gh-fork-ribbon.css"}
<!--[if lt IE 9]>
#{stylesheet_link_tag "github-fork-ribbon-css/gh-fork-ribbon.ie.css"}
<![endif]-->
          EOS

          div_tag_str = <<-EOS
<div class="github-fork-ribbon-wrapper #{position}#{fixed}" onClick="this.style.display='none'" title="#{title}"><div class="github-fork-ribbon #{color}"><span class="github-fork-ribbon-text">#{env}</span></div></div>
          EOS

          html
            .sub(%r{(</head>)}i, "#{style_tag_str.strip}\\1")
            .sub(%r{(<body[^>]*>)}i, "\\1#{div_tag_str.strip}")
        end
      end
    end
  end
end
