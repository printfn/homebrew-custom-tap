class Clagrange < Formula
  desc "Beautiful Gemini Client"
  homepage "https://gmi.skyjake.fi/lagrange/"
  url "https://github.com/skyjake/lagrange/releases/download/v1.13.7/lagrange-1.13.7.tar.gz"
  sha256 "7fe70d06cfa80fcf7122f1a537a2205d844dd6e9efcc4d6dd712861faa3f2e14"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build
  depends_on "libunistring"
  depends_on "ncurses"
  depends_on "openssl"
  depends_on "pcre"

  resource "sealcurses" do
    url "https://git.skyjake.fi/skyjake/sealcurses/archive/b0667079251f0eb3e6291a0ae5eecc31c996dc8b.tar.gz"
    sha256 "5095f1ee25aa2ee3390966aa4891278e2c5a4ab85f6c0ce61cfffedc9de50b5a"
  end

  def install
    mkdir "build" do
      mkdir "build-tfdn" do
        system "cmake", "../../lib/the_Foundation",
                        *std_cmake_args,
                        "-DTFDN_STATIC_LIBRARY=YES",
                        "-DTFDN_ENABLE_WEBREQUEST=NO",
                        "-DTFDN_ENABLE_TESTS=NO",
                        "-DCMAKE_INSTALL_PREFIX=#{buildpath}"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end

      (buildpath/"lib/sealcurses").install resource("sealcurses")

      mkdir "build-sealcurses" do
        system "cmake", "../../lib/sealcurses",
                        *std_cmake_args,
                        "-DENABLE_SHARED=NO",
                        "-Dthe_Foundation_DIR=#{buildpath}/lib/cmake/the_Foundation",
                        "-DCMAKE_INSTALL_PREFIX=#{buildpath}"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end

      ENV.prepend_path "PKG_CONFIG_PATH", "#{buildpath}/lib/pkgconfig"

      mkdir "build-tui" do
        system "cmake", "../..",
                        *std_cmake_args,
                        "-DENABLE_TUI=YES",
                        "-DENABLE_MPG123=NO",
                        "-DENABLE_WEBP=NO",
                        "-DENABLE_FRIBIDI=NO",
                        "-DENABLE_HARFBUZZ=NO",
                        "-DENABLE_POPUP_MENUS=NO",
                        "-DENABLE_IDLE_SLEEP=NO",
                        "-Dthe_Foundation_DIR=#{buildpath}/lib/cmake/the_Foundation"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end
    end
  end

  test do
    system "false"
  end
end
