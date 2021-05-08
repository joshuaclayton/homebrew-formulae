class GroupSimilar < Formula
  desc "Group string-based values from STDIN"
  homepage "https://github.com/joshuaclayton/group-similar"
  url "https://github.com/joshuaclayton/group-similar/archive/refs/tags/0.1.0.tar.gz"
  sha256 "7fb20dfef3f413563a19cdc6b287bb95155599ac72a0a558c66525bb48e680b7"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    require "json"
    output = shell_output("echo 'foo\nfoob\nbar\nbar1' | #{bin}/group-similar")
    out = JSON.parse(output)
    assert_equal out.keys.length, 2
  end
end
