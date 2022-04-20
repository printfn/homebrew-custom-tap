class MicroInetd < Formula
  desc "Simple network service spawner"
  homepage "https://acme.com/software/micro_inetd/"
  url "https://acme.com/software/micro_inetd/micro_inetd_14Aug2014.tar.gz"
  sha256 "15f5558753bb50ed18e4a1445b3e8a185f3b1840ec8e017a5e6fc7690616ec52"
  version "2014-08-14"
  license :cannot_represent

  def install
    system "mkdir", "-p", bin
    system "mkdir", "-p", man1
    system "make", "install", "BINDIR=#{bin}", "MANDIR=#{man1}"
  end

  test do
    system "false"
  end
end
