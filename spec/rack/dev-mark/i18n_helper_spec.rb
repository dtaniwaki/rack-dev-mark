# encoding: utf-8
require 'spec_helper'

if defined?(::I18n)
describe Rack::DevMark::I18nHelper do
  let(:translations) {
    {
      ja: {
        rack_dev_mark: {
          test: 'テスト'
        }
      }
    }
  }
  before do
    ::I18n.locale = :ja
    ::I18n.backend.store_translations(:ja, translations[:ja])
  end
  after do
    ::I18n.backend.store_translations(:ja, {})
    ::I18n.locale = :en
  end
  it "returns i18n string" do
    Rack::DevMark.env = 'test'
    expect(Rack::DevMark.env).to eq('テスト')
  end
  context "without matched key" do
    it "returns original string" do
      Rack::DevMark.env = 'foo'
      expect(Rack::DevMark.env).to eq('foo')
    end
  end
end
end
