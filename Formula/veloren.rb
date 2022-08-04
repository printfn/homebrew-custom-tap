class Veloren < Formula
  desc "Multiplayer voxel RPG"
  homepage "https://veloren.net"
  url "https://gitlab.com/veloren/veloren.git",
    tag:      "v0.13.0",
    revision: "34ae5b9df73f367fa34350337ebba71711f48b86"
  license "GPL-3.0-or-later"

  depends_on "cmake" => :build
  depends_on "git-lfs" => :build
  depends_on "ninja" => :build
  depends_on "rustup-init" => :build

  def install
    system "git", "lfs", "install", "--local"
    system "git", "lfs", "pull"

    # make sure the assets have been downloaded correctly with git-lfs
    unless `file assets/voxygen/background/bg_main.jpg`.match?(/JPEG image/i)
      odie "assets have not been downloaded correctly"
    end

    # this will install the necessary cargo/rustup toolchain bits in HOMEBREW_CACHE
    system Formula["rustup-init"].bin/"rustup-init", "-qy", "--no-modify-path"
    ENV.prepend_path "PATH", HOMEBREW_CACHE/"cargo_cache/bin"

    ENV["VELOREN_USERDATA_STRATEGY"] = "system"

    system "cargo", "install", *std_cargo_args(root: libexec, path: "voxygen")
    system "cargo", "install", *std_cargo_args(root: libexec, path: "server-cli")

    libexec.install "assets"

    (bin/"veloren-voxygen").write_env_script "#{libexec}/bin/veloren-voxygen",
                                             VELOREN_ASSETS: "#{libexec}/assets"
    (bin/"veloren-server-cli").write_env_script "#{libexec}/bin/veloren-server-cli",
                                                VELOREN_ASSETS: "#{libexec}/assets"
  end

  test do
    output = shell_output("echo \"shutdown graceful 0\" | #{bin}/veloren-server-cli")
    assert_match "Server is ready to accept connections", output
  end
end
