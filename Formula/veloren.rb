class Veloren < Formula
  desc "Multiplayer voxel RPG"
  homepage "https://veloren.net"
  url "https://gitlab.com/veloren/veloren/-/archive/v0.13.0/veloren-v0.13.0.tar.gz"
  sha256 "6864e9ac190b07eae7d5ea966472d120037153af086f64cc8a7966a59a5f2cfe"
  license "GPL-3.0-or-later"

  # TODO: fix assets dir, fix git revision hash

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "rustup-init" => :build

  def install
    # this will install the necessary cargo/rustup toolchain bits in HOMEBREW_CACHE
    system Formula["rustup-init"].bin/"rustup-init", "-qy", "--no-modify-path"
    ENV.prepend_path "PATH", HOMEBREW_CACHE/"cargo_cache/bin"

    ENV["VELOREN_USERDATA_STRATEGY"] = "system"
    ENV["NIX_GIT_HASH"] = "00000000/#{time.strftime("%Y-%m-%d-%H:%M")}"
    ENV["NIX_GIT_TAG"] = "v#{version}"

    system "cargo", "install", *std_cargo_args(path: "voxygen")
    system "cargo", "install", *std_cargo_args(path: "server-cli")
  end

  test do
    system "false"
    # assert_match "Airshipper #{version}", shell_output("#{bin}/airshipper --version")
  end
end
