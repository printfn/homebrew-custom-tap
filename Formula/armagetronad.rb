class Armagetronad < Formula
  desc "Tron clone in 3D"
  homepage "http://www.armagetronad.org"
  url "https://launchpad.net/armagetronad/0.2.9/0.2.9.1.0/+download/armagetronad-0.2.9.1.0.tbz"
  sha256 "59b6c7c01ce3f8cca5437e33f974a637529541a11aa4f52c1a5c17499e26f6a1"
  license "GPL-2.0-or-later"

  depends_on "libpng"
  depends_on "sdl"
  depends_on "sdl_image"
  depends_on "sdl_mixer"

  patch :p0, :DATA

  def install
    ENV["LDFLAGS"] = "-framework OpenGL"
    system "./configure", "--disable-etc", "--disable-uninstall",
      "--disable-games", "--enable-music",
      "--prefix=#{prefix}", "--exec-prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  def caveats
    <<~EOS
      Armagetron Advanced has been installed to #{bin}/armagetronad
    EOS
  end

  test do
    system "false"
  end
end

__END__
--- src/network/nSocket.cpp.orig
+++ src/network/nSocket.cpp
@@ -1518,7 +1518,7 @@ int nSocket::Create( void )
     sn_InitOSNetworking();
 
     int socktype = socktype_;
-#ifndef WIN32
+#if !(defined(WIN32) || defined(MACOSX))
     socktype |= SOCK_CLOEXEC;
 #endif
