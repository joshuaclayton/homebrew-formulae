require "language/haskell"

class ImportSort < Formula
  include Language::Haskell::Cabal

  desc "A tool to sort Haskell imports"
  homepage "https://github.com/joshuaclayton/import-sort"
  url "https://github.com/joshuaclayton/import-sort/archive/v0.2.0.0.tar.gz"
  version "0.2.0.0"
  sha256 "900df16e961cc8fe7fa72af98ac1fa358a7aa0b5418ff5c720eb05abde8aabe0"
  head "https://github.com/joshuaclayton/import-sort.git"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build

  def install
    install_cabal_package
  end

  test do
    output = shell_output("echo 'import Foo\\nimport qualified Bar as B' | #{bin}/import-sort")

    assert_match /Bar.*Foo/m, output

    true
  end
end
