class Hextoggle < Formula
  desc "Easily view and edit hex files"
  homepage "https://github.com/printfn/hextoggle"
  url "https://github.com/printfn/hextoggle/archive/refs/tags/v1.0.5.tar.gz", branch: "main"
  sha256 "b06fe39ff8949e6b59491327c319a2a26a15a0b40ad4f80ca4cfae1b6329435e"
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
