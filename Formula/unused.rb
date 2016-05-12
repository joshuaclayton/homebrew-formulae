require "language/haskell"

class Unused < Formula
  include Language::Haskell::Cabal

  desc "A command line tool to identify unused code."
  homepage "https://github.com/joshuaclayton/unused"
  url "https://github.com/joshuaclayton/unused/archive/v0.1.1.0.tar.gz"
  version "0.1.1.0"
  sha256 "accbfc3f5eecee96609845ff82137fbe2d0bd587172785efdad883fb098b59b6"
  head "https://github.com/joshuaclayton/unused.git"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "ag" => :build

  def install
    install_cabal_package
  end

  test do
    code = testpath/"foo.rb"
    code.write <<-EOS.undent
      once
      twice
      twice
      twice
    EOS

    spec = testpath/"spec/foo_spec.rb"
    spec.write <<-EOS.undent
      twice
      twice
      twice
    EOS

    output = shell_output("echo 'once\\ntwice\\nthrice\\n' | #{bin}/unused -a")

    assert_match /once.*foo\.rb/, output
    assert_match /twice.*foo\.rb/, output
    assert_match /twice.*foo_spec\.rb/, output
    refute_match "thrice", output

    true
  end
end
