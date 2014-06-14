require 'spec_helper'

describe Rack::DevMark::Theme::Title do
  it_behaves_like "theme" do
    let (:out) { %Q~<html><head>head<title>(env) title</title></head><body>body</body></html>~ }
    subject { Rack::DevMark::Theme::Title.new }
  end
  context "no title tag" do
    let (:src) { %Q~<html><head>head</head><body>body</body></html>~ }
    let (:out) { %Q~<html><head>head</head><body>body</body></html>~ }
    it "does not insert anything" do
      expect(subject.insert_into(src, 'env', 'rev')).to eq(src)
    end
  end
end
