require 'spec_helper'

describe Rack::DevMark::Theme::Tag do
  include_context "theme context"

  let(:options) { {} }
  subject { Rack::DevMark::Theme::Tag.new(options) }

  it_behaves_like "theme" do
    # No insert
  end

  describe "#env_with_value" do
    context "upcase is true" do
      let(:options) { {upcase: true} }
      it "replace a string" do
        expect(subject.send(:env_with_value, 'env', 'foo')).to eq('(ENV) foo')
      end
    end
    context "upcase is false" do
      let(:options) { {upcase: false} }
      it "replace a string" do
        expect(subject.send(:env_with_value, 'env', 'foo')).to eq('(env) foo')
      end
    end
    context "type is prefix" do
      let(:options) { {type: 'prefix'} }
      it "replace a string" do
        expect(subject.send(:env_with_value, 'env', 'foo')).to eq('(env) foo')
      end
    end
    context "type is postfix" do
      let(:options) { {type: 'postfix'} }
      it "replace a string" do
        expect(subject.send(:env_with_value, 'env', 'foo')).to eq('foo (env)')
      end
    end
  end

  context "with name option" do
    let(:options) { {name: 'div'} }
    context "with one match" do
      it_behaves_like "theme" do
        let(:src) { %Q~<html><head>head<title></title></head><body>body<div>foo</div><span>bar</span></body></html>~ }
        let(:out) { %Q~<html><head>head<title></title></head><body>body<div>(env) foo</div><span>bar</span></body></html>~ }
      end
    end
    context "with multiple matches" do
      it_behaves_like "theme" do
        let(:src) { %Q~<html><head>head<title></title></head><body>body<div>foo</div><div>bar</div></body></html>~ }
        let(:out) { %Q~<html><head>head<title></title></head><body>body<div>(env) foo</div><div>(env) bar</div></body></html>~ }
      end
    end
    context "no match" do
      it_behaves_like "theme" do
        let(:src) { %Q~<html><head>head<title></title></head><body>body<span>foo</span><span>bar</span></body></html>~ }
        let(:out) { %Q~<html><head>head<title></title></head><body>body<span>foo</span><span>bar</span></body></html>~ }
      end
    end
  end

  context "with attribute option" do
    context "one specified attribute" do
      let(:options) { {attribute: 'data-title1' } }
      context "with one match" do
        it_behaves_like "theme" do
          let(:src) { %Q~<html><head>head<title></title></head><body>body<div data-title1="foo">foo</div><div>bar</div></body></html>~ }
          let(:out) { %Q~<html><head>head<title></title></head><body>body<div data-title1="(env) foo">foo</div><div>bar</div></body></html>~ }
        end
      end
      context "with multiple matches" do
        it_behaves_like "theme" do
          let(:src) { %Q~<html><head>head<title></title></head><body>body<div data-title1="foo">foo</div><div data-title1="bar">bar</div></body></html>~ }
          let(:out) { %Q~<html><head>head<title></title></head><body>body<div data-title1="(env) foo">foo</div><div data-title1="(env) bar">bar</div></body></html>~ }
        end
      end
      context "no match" do
        it_behaves_like "theme" do
          let(:src) { %Q~<html><head>head<title></title></head><body>body<div>foo</div><div>bar</div></body></html>~ }
          let(:out) { %Q~<html><head>head<title></title></head><body>body<div>foo</div><div>bar</div></body></html>~ }
        end
      end
    end
    context "multiple specified attributes" do
      let(:options) { {attribute: ['data-title1', 'data-title2'] } }
      context "with one match" do
        it_behaves_like "theme" do
          let(:src) { %Q~<html><head>head<title></title></head><body>body<div data-title1="foo" data-title2="abc">foo</div><div>bar</div></body></html>~ }
          let(:out) { %Q~<html><head>head<title></title></head><body>body<div data-title1="(env) foo" data-title2="(env) abc">foo</div><div>bar</div></body></html>~ }
        end
      end
      context "with multiple matches" do
        it_behaves_like "theme" do
          let(:src) { %Q~<html><head>head<title></title></head><body>body<div data-title1="foo" data-title2="abc">foo</div><div data-title1="bar" data-title2="xyz">bar</div></body></html>~ }
          let(:out) { %Q~<html><head>head<title></title></head><body>body<div data-title1="(env) foo" data-title2="(env) abc">foo</div><div data-title1="(env) bar" data-title2="(env) xyz">bar</div></body></html>~ }
        end
      end
      context "no match" do
        it_behaves_like "theme" do
          let(:src) { %Q~<html><head>head<title></title></head><body>body<div>foo</div><div>bar</div></body></html>~ }
          let(:out) { %Q~<html><head>head<title></title></head><body>body<div>foo</div><div>bar</div></body></html>~ }
        end
      end
    end
  end
end
