require 'spec_helper'

describe Rack::DevMark::Theme::Base do
  it "has private initialize method" do
    expect {
      Rack::DevMark::Theme::Base.new
    }.to raise_error(Rack::DevMark::RuntimeError)
  end
  describe "subclass" do
    subject { Class.new(Rack::DevMark::Theme::Base).new }
    describe "#gsub_tag_content" do
      let(:input) { %Q|<body><h1>head</h1><a href="something">x</a><span></span>y</div>| }
      let(:output) { %Q|<body><h1>head</h1><a href="something">replaced</a><span></span>y</div>| }
      it "replaces a string" do
        expect(subject.send(:gsub_tag_content, input, 'a', &lambda{ |v| 'replaced' })).to eq(output)
      end
      context "for multiple tags" do
        let(:input) { %Q|<body><h1>head</h1><a href="something">x</a><a href="anything">y</a></div>| }
        let(:output) { %Q|<body><h1>head</h1><a href="something">replaced</a><a href="anything">replaced</a></div>| }
        it "replaces a string" do
          expect(subject.send(:gsub_tag_content, input, 'a', &lambda{ |v| 'replaced' })).to eq(output)
        end
      end
      context "for nested tags" do
        let(:input) { %Q|<body><h1>head</h1><a href="something"><span>x</span></a><span>y</span></div>| }
        let(:output) { %Q|<body><h1>head</h1><a href="something"><span>x</span></a><span>y</span></div>| }
        it "does not replace a string" do
          expect(subject.send(:gsub_tag_content, input, 'a', &lambda{ |v| 'replaced' })).to eq(output)
        end
      end
    end
    describe "#gsub_tag_attribute" do
      let(:input) { %Q|<body><h1>head</h1><a href="something" data-title="x" data-body="x">x</a><span data-title="y">y</span></div>| }
      let(:output) { %Q|<body><h1>head</h1><a href="something" data-title="replaced" data-body="x">x</a><span data-title="y">y</span></div>| }
      it "replaces a string" do
        expect(subject.send(:gsub_tag_attribute, input, 'a', 'data-title', &lambda{ |v| 'replaced' })).to eq(output)
      end
      context "for multiple tags" do
        let(:input) { %Q|<body><h1>head</h1><a href="something" data-title="x" data-body="x">x</a><a href="anything" data-title="y">y</a></div>| }
        let(:output) { %Q|<body><h1>head</h1><a href="something" data-title="replaced" data-body="x">x</a><a href="anything" data-title="replaced">y</a></div>| }
        it "replaces a string" do
          expect(subject.send(:gsub_tag_attribute, input, 'a', 'data-title', &lambda{ |v| 'replaced' })).to eq(output)
        end
      end
      context "for single tag" do
        let(:input) { %Q|<body><h1>head</h1><a href="something" data-title="x" data-body="x">x</a><span href="anything" data-title="y">y</span><img data-title="i"></div>| }
        let(:output) { %Q|<body><h1>head</h1><a href="something" data-title="x" data-body="x">x</a><span href="anything" data-title="y">y</span><img data-title="replaced"></div>| }
        it "replaces a string" do
          expect(subject.send(:gsub_tag_attribute, input, 'img', 'data-title', &lambda{ |v| 'replaced' })).to eq(output)
        end
      end
      context "for any tags" do
        let(:input) { %Q|<body><h1>head</h1><a href="something" data-title="x" data-body="x">x</a><span href="anything" data-title="y">y</span></div>| }
        let(:output) { %Q|<body><h1>head</h1><a href="something" data-title="replaced" data-body="x">x</a><span href="anything" data-title="replaced">y</span></div>| }
        it "replaces a string" do
          expect(subject.send(:gsub_tag_attribute, input, nil, 'data-title', &lambda{ |v| 'replaced' })).to eq(output)
        end
      end
      context "with single quotations" do
        let(:input) { %Q|<body><h1>head</h1><a href='something' data-title='x' data-body='x'>x</a><span data-title='y'>y</span></div>| }
        let(:output) { %Q|<body><h1>head</h1><a href='something' data-title='replaced' data-body='x'>x</a><span data-title='y'>y</span></div>| }
        it "replaces a string" do
          expect(subject.send(:gsub_tag_attribute, input, 'a', 'data-title', &lambda{ |v| 'replaced' })).to eq(output)
        end
      end
    end
  end
end
