class Hextoggle < Formula
  desc "Easily view and edit hex files"
  homepage "https://github.com/printfn/hextoggle"
  url "https://github.com/printfn/hextoggle/archive/refs/tags/v1.0.0.tar.gz", branch: "main"
  sha256 "54bb0f1d594e3ca7dbcf63fe9d746e241f6641aa1f21ec9fd33fdefb640edb89"
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
