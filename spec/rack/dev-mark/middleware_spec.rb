require 'spec_helper'

describe Rack::DevMark::Middleware do
  let(:headers) { {'Content-Type' => 'text/html; charset=utf-8'} }
  let(:body) { ['response'] }
  let(:app) { double call: [200, headers, body] }
  subject { Rack::DevMark::Middleware.new(app) }
  before do
    allow(Rack::DevMark).to receive(:env).and_return('test')
    allow(Rack::DevMark).to receive(:revision).and_return('rev')
  end

  it "inserts dev mark" do
    expect_any_instance_of(Rack::DevMark::Title).to receive(:insert_into){ |body, _, _| "title #{body}" }.once
    expect_any_instance_of(Rack::DevMark::Theme::GithubForkRibbon).to receive(:insert_into){ |body, _, _| "#{body} dev-mark" }.once
    status, headers, body = subject.call({})
    expect(status).to eq(200)
    expect(headers).to include('Content-Type' => 'text/html; charset=utf-8')
    expect(body).to eq(["title response dev-mark"])
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
