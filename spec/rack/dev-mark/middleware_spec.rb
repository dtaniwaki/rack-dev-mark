require 'spec_helper'

describe Rack::DevMark::Middleware do
  let(:headers) { {'Content-Type' => 'text/html; charset=utf-8'} }
  let(:body) { ['response'] }
  let(:theme) { Class.new(Rack::DevMark::Theme::Base).new }
  let(:app) { double call: [200, headers, body] }
  subject { Rack::DevMark::Middleware.new(app, theme) }
  before do
    allow(Rack::DevMark).to receive(:env).and_return('test')
    allow(Rack::DevMark).to receive(:revision).and_return('rev')
    allow_any_instance_of(Rack::DevMark::Title).to receive(:insert_into){ |body, _, _| "title #{body}" }
    allow(theme).to receive(:insert_into){ |body, _, _| "#{body} dev-mark" }
  end

  it "inserts dev mark" do
    status, headers, body = subject.call({})
    expect(status).to eq(200)
    expect(headers).to include('Content-Type' => 'text/html; charset=utf-8')
    expect(body).to eq(["title response dev-mark"])
  end
  it "adds http headers" do
    _, headers, _ = subject.call({})
    expect(headers).to include('X-Rack-Dev-Mark-Env' => 'test')
  end
  context "default theme" do
    subject { Rack::DevMark::Middleware.new(app) }
    it "uses github_fork_ribbon" do
      expect_any_instance_of(Rack::DevMark::Theme::GithubForkRibbon).to receive(:insert_into).and_return('')
      subject.call({})
    end
  end
  context "not html request" do
    let(:headers) { {'Content-Type' => 'application/json;'} }
    let(:body) { ['{}'] }
    it "does not insert planbcd tag if the body does not have head tag" do
      expect_any_instance_of(Rack::DevMark::Title).not_to receive(:insert_into)
      expect_any_instance_of(Rack::DevMark::Theme::GithubForkRibbon).not_to receive(:insert_into)
      status, headers, body = subject.call({})
      expect(status).to eq(200)
      expect(headers).to include('Content-Type' => 'application/json;')
      expect(body).to eq(['{}'])
    end
  end
end
