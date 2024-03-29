class PicoSdk < Formula
  desc "Raspberry Pi Pico SDK"
  homepage "https://github.com/raspberrypi/pico-sdk"
  url "https://github.com/raspberrypi/pico-sdk/archive/refs/tags/1.4.0.tar.gz"
  sha256 "951d1d316d9a01c734c5ec53e766a2d03fb44f405a2494bac9a8a7c178e25918"
  license "BSD-3-Clause"
  head "https://github.com/raspberrypi/pico-sdk.git", branch: "master"

  depends_on "cmake" => :test

  def install
    pkgshare.install Dir["*"]
  end

  def caveats
    <<~EOS
      Add the following line to your .bashrc or equivalent:
        export PICO_SDK_PATH="#{HOMEBREW_PREFIX}/share/pico-sdk"
    EOS
  end

  test do
    # tests are currently broken
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include "pico/stdlib.h"

      int main() {
          setup_default_uart();
          printf("Hello, world!\n");
          return 0;
      }
    EOS
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.13)

      include(pico_sdk_import.cmake)

      project(my_project)

      # initialize the Raspberry Pi Pico SDK
      pico_sdk_init()

      add_executable(hello_world hello_world.c)

      # Add pico_stdlib library which aggregates commonly used features
      target_link_libraries(hello_world pico_stdlib)

      # create map/bin/hex/uf2 file in addition to ELF.
      pico_add_extra_outputs(hello_world)
    EOS
    cp pkgshare/"external"/"pico_sdk_import.cmake", testpath
    ENV["PICO_SDK_PATH"] = "#{HOMEBREW_PREFIX}/share/pico-sdk"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "make", "hello_world"
  end
end
