require "language/haskell"

class Unused < Formula
  include Language::Haskell::Cabal

  desc "A command line tool to identify unused code."
  homepage "https://github.com/joshuaclayton/unused"
  url "https://github.com/joshuaclayton/unused/archive/v0.9.0.0.tar.gz"
  version "0.9.0.0"
  sha256 "af19cda3311397bbb9ebfb9c48bc574b0e3d911ea52c2d8151e745ee5f99b33d"
  head "https://github.com/joshuaclayton/unused.git"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "ag" => :recommended
  depends_on "ctags" => :recommended
  depends_on "rg" => :optional

  def install
    install_cabal_package
  end

  test do
    code = testpath/"awesome.rb"
    code.write <<-EOS.undent
      class Awesome
        def once
          twice
        end

        def twice
          @twice || 2
        end
      end
    EOS

    spec = testpath/"spec/awesome_spec.rb"
    spec.write <<-EOS.undent
      require "spec_helper"

      describe Awesome do
        it "uses twice" do
          expect(subject.once).to eq subject.twice
        end
      end
    EOS

    output = shell_output("echo 'once\\ntwice\\nthrice\\nonce\\n' | #{bin}/unused -a --stdin")

    assert_match /once.*awesome\.rb/, output
    assert_match /twice.*awesome\.rb/, output
    assert_match /twice.*awesome_spec\.rb/, output
    refute_match "thrice", output

    true
  end
end
