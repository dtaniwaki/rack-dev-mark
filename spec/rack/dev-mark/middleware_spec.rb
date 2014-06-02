require 'spec_helper'

describe Rack::DevMark::Middleware do
  let(:app) { double call: [200, {'Content-Type' => 'text/html; charset=utf-8'}, ['response']] }
  subject { Rack::DevMark::Middleware.new(app) }
  before do
    allow(Rack::DevMark).to receive(:env).and_return('test')
    allow(Rack::DevMark).to receive(:revision).and_return('rev')
  end

  it "inserts planbcd tag" do
    expect_any_instance_of(Rack::DevMark::Title).to receive(:insert_into).with('response', 'test', 'rev').once.and_return('response')
    expect_any_instance_of(Rack::DevMark::Theme::GithubForkRibbon).to receive(:insert_into).with('response', 'test', 'rev').once.and_return('response')
    status, headers, body = subject.call({})
    expect(status).to eq(200)
    expect(headers).to eq({'Content-Type' => 'text/html; charset=utf-8'})
    expect(body).to eq(['response'])
  end
  context "not html request" do
    let(:app) { double call: [200, {'Content-Type' => 'application/json;'}, ['{}']] }
    it "does not insert planbcd tag if the body does not have head tag" do
      expect_any_instance_of(Rack::DevMark::Title).not_to receive(:insert_into)
      expect_any_instance_of(Rack::DevMark::Theme::GithubForkRibbon).not_to receive(:insert_into)
      status, headers, body = subject.call({})
      expect(status).to eq(200)
      expect(headers).to eq({'Content-Type' => 'application/json;'})
      expect(body).to eq(['{}'])
    end
  end
end
