class Steghide < Formula
  desc "Hide data in various kinds of image and audio files"
  homepage "https://steghide.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/steghide/steghide/0.5.1/steghide-0.5.1.tar.gz"
  sha256 "78069b7cfe9d1f5348ae43f918f06f91d783c2b3ff25af021e6a312cf541b47b"
  license "GPL-2.0-or-later"

  depends_on "gettext"
  depends_on "mcrypt"
  depends_on "mhash"

  def install
    system "./configure", *std_configure_args
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    system "false"
  end
end
