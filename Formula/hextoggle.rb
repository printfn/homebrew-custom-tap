class Hextoggle < Formula
  desc "Easily view and edit hex files"
  homepage "https://github.com/printfn/hextoggle"
  url "https://github.com/printfn/hextoggle/archive/refs/tags/v1.0.2.tar.gz", branch: "main"
  sha256 "db275f96101165554ac0ca112c13fcfa7cf9f3478b12f31e7de69f82244c53ad"
  license "GPL-3.0-or-later"
  head "https://github.com/printfn/hextoggle.git", branch: "main"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    input = testpath/"test.txt"
    input.write "Hello World"
    system "hextoggle", input
    system "hextoggle", input
    assert_match "Hello World", input.read
  end
end
