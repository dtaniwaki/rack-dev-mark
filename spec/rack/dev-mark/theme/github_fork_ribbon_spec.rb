require 'spec_helper'

describe Rack::DevMark::Theme::GithubForkRibbon do
  include_context "theme context"
  it_behaves_like "theme" do
    let :out do
      s = <<-EOS
<html><head>head<title>title</title><style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.css"}</style>
<!--[if lt IE 9]>
<style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.ie.css"}</style>
<![endif]--></head><body><div class="github-fork-ribbon-wrapper left" onClick="this.style.display='none'" title="rev&#10;time"><div class="github-fork-ribbon red"><span class="github-fork-ribbon-text">env</span></div></div>body</body></html>
      EOS
      s.strip
    end

    subject { Rack::DevMark::Theme::GithubForkRibbon.new }
  end
  context "position option" do
    it_behaves_like "theme" do
      let :out do
        s = <<-EOS
<html><head>head<title>title</title><style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.css"}</style>
<!--[if lt IE 9]>
<style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.ie.css"}</style>
<![endif]--></head><body><div class="github-fork-ribbon-wrapper right" onClick="this.style.display='none'" title="rev&#10;time"><div class="github-fork-ribbon red"><span class="github-fork-ribbon-text">env</span></div></div>body</body></html>
        EOS
        s.strip
      end

      subject { Rack::DevMark::Theme::GithubForkRibbon.new(position: 'right') }
    end
  end
  context "color option" do
    it_behaves_like "theme" do
      let :out do
        s = <<-EOS
<html><head>head<title>title</title><style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.css"}</style>
<!--[if lt IE 9]>
<style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.ie.css"}</style>
<![endif]--></head><body><div class="github-fork-ribbon-wrapper left" onClick="this.style.display='none'" title="rev&#10;time"><div class="github-fork-ribbon orange"><span class="github-fork-ribbon-text">env</span></div></div>body</body></html>
        EOS
        s.strip
      end

      subject { Rack::DevMark::Theme::GithubForkRibbon.new(color: 'orange') }
    end
  end
  context "fixed option" do
    it_behaves_like "theme" do
      let :out do
        s = <<-EOS
<html><head>head<title>title</title><style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.css"}</style>
<!--[if lt IE 9]>
<style>#{read_stylesheet "github-fork-ribbon-css/gh-fork-ribbon.ie.css"}</style>
<![endif]--></head><body><div class="github-fork-ribbon-wrapper left fixed" onClick="this.style.display='none'" title="rev&#10;time"><div class="github-fork-ribbon red"><span class="github-fork-ribbon-text">env</span></div></div>body</body></html>
        EOS
        s.strip
      end

      subject { Rack::DevMark::Theme::GithubForkRibbon.new(fixed: true) }
    end
  end
end
