class Hextoggle < Formula
  desc "Easily view and edit hex files"
  homepage "https://github.com/printfn/hextoggle"
  url "https://github.com/printfn/hextoggle/archive/refs/tags/v1.0.6.tar.gz", branch: "main"
  sha256 "9a634464c25a431a00457d31eea6d4e7d13df40b16a951064178c75abf1ddb2f"
  license "0BSD"
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
