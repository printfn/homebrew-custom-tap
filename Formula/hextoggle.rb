class Hextoggle < Formula
  desc "Easily view and edit hex files"
  homepage "https://github.com/printfn/hextoggle"
  url "https://github.com/printfn/hextoggle/archive/refs/tags/v1.0.4.tar.gz", branch: "main"
  sha256 "c6d8155a4e20d29816df3f244eed0e09ece2a58f694410bb0ad1107427befbad"
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
