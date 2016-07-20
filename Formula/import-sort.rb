require "language/haskell"

class ImportSort < Formula
  include Language::Haskell::Cabal

  desc "A tool to sort Haskell imports"
  homepage "https://github.com/joshuaclayton/import-sort"
  url "https://github.com/joshuaclayton/import-sort/archive/v0.1.0.0.tar.gz"
  version "0.1.0.0"
  sha256 "0a9cfd9d8f1ab46e407be2e48207654ede427f683de57256d393da7b1332bbf1"
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
