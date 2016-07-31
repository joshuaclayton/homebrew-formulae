require "language/haskell"

class ImportSort < Formula
  include Language::Haskell::Cabal

  desc "A tool to sort Haskell imports"
  homepage "https://github.com/joshuaclayton/import-sort"
  url "https://github.com/joshuaclayton/import-sort/archive/v0.3.0.0.tar.gz"
  version "0.3.0.0"
  sha256 "b6dc907e7f6c8ff92d06d1f2fdbc221f9e6ad9db19d136ac58e49dcf5cfc273c"
  head "https://github.com/joshuaclayton/import-sort.git"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build

  def install
    install_cabal_package
  end

  test do
    output = shell_output("echo 'import Foo\\nimport qualified Bar as B' | #{bin}/import-sort")

    assert_match(/Bar.*Foo/m, output)

    true
  end
end
