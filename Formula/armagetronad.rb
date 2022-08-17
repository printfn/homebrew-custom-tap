class Armagetronad < Formula
  desc "Tron clone in 3D"
  homepage "http://www.armagetronad.org"
  url "https://launchpad.net/armagetronad/0.2.9/0.2.9.1.0/+download/armagetronad-0.2.9.1.0.tbz"
  sha256 "59b6c7c01ce3f8cca5437e33f974a637529541a11aa4f52c1a5c17499e26f6a1"
  license "GPL-2.0-or-later"

  livecheck do
    url "http://www.armagetronad.org/downloads.php"
    regex(/href=.*?armagetronad[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/printfn/homebrew-custom-tap/releases/download/armagetronad-0.2.9.1.0"
    sha256 monterey: "b9fcddc482533b37609bc493a3df8ec6564eaf3d8d45ad1af702aec5b1ca5179"
  end

  depends_on "libpng"
  depends_on "sdl"
  depends_on "sdl_image"
  depends_on "sdl_mixer"

  patch do
    url "https://raw.githubusercontent.com/printfn/homebrew-custom-tap/71b607e08ba827ac180903c2dc5ed0c37e2c33a6/patches/armagetronad-aaf6296d1487d66f3c2cb0b5bf126cfe5b2c26e8482175f69b744ffde3e6fc8e.diff"
    sha256 "aaf6296d1487d66f3c2cb0b5bf126cfe5b2c26e8482175f69b744ffde3e6fc8e"
  end

  def install
    ENV["LDFLAGS"] = "-framework OpenGL"
    system "./configure", *std_configure_args,
                          "--disable-etc",
                          "--disable-uninstall",
                          "--disable-games",
                          "--enable-automakedefaults",
                          "--enable-music",
                          "--disable-sysinstall",
                          "--bindir=#{libexec}"
    system "make"
    system "make", "install"

    (bin/"armagetronad").write <<~SH
      #!/bin/bash
      exec #{libexec}/armagetronad --datadir #{pkgshare} --configdir #{etc}/armagetronad "$@"
    SH
  end

  test do
    system "false"
  end
end
