RSpec.shared_examples "theme" do
  def read_stylesheet(path)
    ::File.open(::File.join(::File.dirname(__FILE__), '../../vendor/assets/stylesheets', path)).read
  end

  let (:src) { %Q~<html><head>head<title>title</title></head><body>body</body></html>~ }
  it "insert env mark" do
    expect(subject.insert_into(src, 'env', 'rev')).to eq(out)
  end
end
