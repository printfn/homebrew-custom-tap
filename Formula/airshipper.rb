class Airshipper < Formula
  desc "Launcher for Veloren, a multiplayer voxel RPG"
  homepage "https://veloren.net"
  url "https://gitlab.com/veloren/airshipper/-/archive/v0.7.0/airshipper-v0.7.0.tar.gz"
  sha256 "dd68535fe6a7a4f01186b590c33e7b12bc79c8aa8a96529e22f9321ea2a06325"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/printfn/homebrew-custom-tap/releases/download/veloren-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ee61536b9f373420adf1b27a4dcf551b807fc75aef18c50256d4547cbe1de3fe"
    sha256 cellar: :any_skip_relocation, monterey:       "d4b4c121fc927e19c2043ad7d7aea77021240333bd78ce821070f3d015b88fec"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "client")
    system "cargo", "install", *std_cargo_args(path: "server")
  end

  test do
    assert_match "Done", shell_output("#{bin}/airshipper update")
  end
end
