require 'spec_helper'

describe Rack::DevMark::Theme::Title do
  include_context "theme context"

  let(:options) { {} }
  subject { Rack::DevMark::Theme::Title.new(options) }

  it_behaves_like "theme" do
    let (:src) { %Q~<html><head>head<title>title</title></head><body>body</body></html>~ }
    let (:out) { %Q~<html><head>head<title>(env) title</title></head><body>body</body></html>~ }
  end
end
