class Fnd < Formula
  desc "Find files fast"
  homepage "https://github.com/joshuaclayton/fnd"
  url "https://github.com/joshuaclayton/fnd/archive/refs/tags/0.1.0.tar.gz"
  sha256 "9c502d3614aef4191af05e76c304ebee64450820473458238426a1566cfebf66"
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

    output = shell_output("#{bin}/fnd '\.rb' -r")

    assert_match /bar\.rb/, output
    assert_match /foo\.rb/, output
    refute_match /bar\.html\.erb/, output
  end
end
