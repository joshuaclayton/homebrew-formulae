class Fnd < Formula
  desc "Find files fast"
  homepage "https://github.com/joshuaclayton/fnd"
  url "https://github.com/joshuaclayton/fnd/archive/refs/tags/0.2.0.tar.gz"
  sha256 "5763d40e416223b2fe1cdfe6fd49a6a29ef5404e693dd9b99bbe532224b3f00f"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    (testpath / "foo.rb").write ""
    (testpath / "bar.rb").write ""
    (testpath / "bar.html.erb").write ""

    output = shell_output("#{bin}/fnd bar")

    assert_match /bar\.rb/, output
    assert_match /bar\.html\.erb/, output
    refute_match /foo\.rb/, output

    output = shell_output("#{bin}/fnd '\\.rb' -r")

    assert_match /bar\.rb/, output
    assert_match /foo\.rb/, output
    refute_match /bar\.html\.erb/, output
  end
end
