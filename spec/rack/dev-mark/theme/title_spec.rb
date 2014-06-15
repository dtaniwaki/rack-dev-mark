require 'spec_helper'

describe Rack::DevMark::Theme::Title do
  include_context "theme context"
  it_behaves_like "theme" do
    let (:out) { %Q~<html><head>head<title>(env) title</title></head><body>body</body></html>~ }
    subject { Rack::DevMark::Theme::Title.new }
  end
  context "upcase is true" do
    let (:out) { %Q~<html><head>head<title>(ENV) title</title></head><body>body</body></html>~ }
    subject { Rack::DevMark::Theme::Title.new(upcase: true) }
    it_behaves_like "theme"
  end
  context "upcase is true" do
    let (:out) { %Q~<html><head>head<title>(env) title</title></head><body>body</body></html>~ }
    subject { Rack::DevMark::Theme::Title.new(upcase: false) }
    it_behaves_like "theme"
  end
  context "type is prefix" do
    let (:out) { %Q~<html><head>head<title>(env) title</title></head><body>body</body></html>~ }
    subject { Rack::DevMark::Theme::Title.new(type: 'prefix') }
    it_behaves_like "theme"
  end
  context "type is postfix" do
    let (:out) { %Q~<html><head>head<title>title (env)</title></head><body>body</body></html>~ }
    subject { Rack::DevMark::Theme::Title.new(type: 'postfix') }
    it_behaves_like "theme"
  end
  context "no title tag" do
    let (:src) { %Q~<html><head>head</head><body>body</body></html>~ }
    let (:out) { %Q~<html><head>head</head><body>body</body></html>~ }
    it "does not insert anything" do
      expect(subject.insert_into(src)).to eq(src)
    end
  end
end
