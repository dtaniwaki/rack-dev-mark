require 'spec_helper'

describe Rack::DevMark::Middleware do
  let(:headers) { {'Content-Type' => 'text/html; charset=utf-8'} }
  let(:body) { ['response'] }
  let(:theme) { d = double setup: nil; allow(d).to receive(:insert_into){ |b| "#{b} dev-mark" }; d }
  let(:app) { double call: [200, headers, body] }
  subject { Rack::DevMark::Middleware.new(app, theme) }
  before do
    allow(Rack::DevMark).to receive(:env).and_return('test')
    allow(Rack::DevMark).to receive(:revision).and_return('rev')
  end

  it "inserts dev mark" do
    status, headers, body = subject.call({})
    expect(status).to eq(200)
    expect(headers).to include('Content-Type' => 'text/html; charset=utf-8')
    expect(body).to eq(["response dev-mark"])
  end
  it "adds http headers" do
    _, headers, _ = subject.call({})
    expect(headers).to include('X-Rack-Dev-Mark-Env' => 'test')
  end
  context "symbol theme" do
    let(:theme) { :title }
    it "uses title" do 
      expect_any_instance_of(Rack::DevMark::Theme::Title).to receive(:insert_into).once.and_return('')
      subject.call({})
    end
  end
  context "multiple themes" do
    let(:_theme) { d = double setup: nil; allow(d).to receive(:insert_into){ |b| "#{b} dev-mark" }; d }
    let(:theme) { [_theme] * 3 }
    it "uses title and github_fork_ribbon" do
      theme.each_with_index do |theme, idx|
        expect(theme).to receive(:insert_into).once.and_return('')
      end
      subject.call({})
    end
  end
  context "default themes" do
    subject { Rack::DevMark::Middleware.new(app) }
    it "uses title and github_fork_ribbon" do
      expect_any_instance_of(Rack::DevMark::Theme::Title).to receive(:insert_into).once.and_return('')
      expect_any_instance_of(Rack::DevMark::Theme::GithubForkRibbon).to receive(:insert_into).once.and_return('')
      subject.call({})
    end
  end
  context "not html request" do
    let(:headers) { {'Content-Type' => 'application/json;'} }
    let(:body) { ['{}'] }
    it "does not insert planbcd tag if the body does not have head tag" do
      expect(theme).not_to receive(:insert_to)
      status, headers, body = subject.call({})
      expect(status).to eq(200)
      expect(headers).to include('Content-Type' => 'application/json;')
      expect(body).to eq(['{}'])
    end
  end
  context "themes raise exceptions" do
    before do
      allow(theme).to receive(:insert_into).and_raise('something happened')
    end
    it "does not raise an exception but write it down in $stderr" do
      expect($stderr).to receive(:write).with(/something happened/)
      subject.call({})
    end
  end
end
