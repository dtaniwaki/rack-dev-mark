RSpec.shared_context "theme context" do
  def read_stylesheet(path)
    ::File.open(::File.join(::File.dirname(__FILE__), '../../vendor/assets/stylesheets', path)).read
  end
end

RSpec.shared_examples "theme" do
  let (:src) { %Q~<html><head>head<title>title</title></head><body>body</body></html>~ }
  let (:out) { %Q~<html><head>head<title>title</title></head><body>body</body></html>~ }
  it "inserts env mark" do
    expect(subject.insert_into(src, 'env', revision: 'rev', timestamp: 'time')).to eq(out)
  end
end
