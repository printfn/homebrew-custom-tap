class Pijul < Formula
  desc "Sound distributed version control system"
  homepage "https://nest.pijul.com/pijul/pijul"
  url "https://static.crates.io/crates/pijul/pijul-1.0.0-beta.2.crate"
  sha256 "9e0870af813cdab0a8f8f3687f545714fc0f6aeee47a2447bea3bf3ce6706dc5"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://crates.io/api/v1/crates/pijul/versions"
    regex(/"num":\s*"(\d+(?:\.\d+|-beta)+)"/i)
  end

  depends_on "rust" => :build
  depends_on "nettle"
  depends_on "xxhash"

  def install
    system "tar", "--strip-components", "1", "-xzvf", "pijul-#{version}.crate"
    system "cargo", "install", "--features", "git", *std_cargo_args
  end

  test do
    system "false"
  end
end
