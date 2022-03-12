class CargoDepgraph < Formula
  desc "Creates dependency graphs for cargo projects"
  homepage "https://sr.ht/~jplatte/cargo-depgraph/"
  url "https://git.sr.ht/~jplatte/cargo-depgraph/archive/v1.2.2.tar.gz"
  sha256 "7f56739ca920d3be998bfd2365fd0f5d468b9297352269ea043169ae87005349"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "false"
  end
end
