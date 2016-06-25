require "language/haskell"

class Unused < Formula
  include Language::Haskell::Cabal

  desc "A command line tool to identify unused code."
  homepage "https://github.com/joshuaclayton/unused"
  url "https://github.com/joshuaclayton/unused/archive/v0.5.0.2.tar.gz"
  version "0.5.0.2"
  sha256 "11b5010658ebaff124287c406823de83a5ea1685fd1ade411bf11269b9c52eec"
  head "https://github.com/joshuaclayton/unused.git"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "ag" => :build

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
