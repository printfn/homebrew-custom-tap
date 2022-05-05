class Pijul < Formula
  desc "The sound distributed version control system"
  homepage "https://nest.pijul.com/pijul/pijul"
  url "https://static.crates.io/crates/pijul/pijul-1.0.0-beta.crate"
  sha256 "bcc69929df7f7e308462c10de25fe2a61f2a6d7c5a93464cee165efd45272cd5"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://crates.io/api/v1/crates/pijul/versions"
    regex(/"num":\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "nettle"
  depends_on "rust" => :build
  depends_on "xxhash"

  def install
    system "tar", "--strip-components", "1", "-xzvf", "pijul-#{version}.crate"
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "false"
  end
end
