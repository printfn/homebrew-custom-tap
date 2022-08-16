class Memzoom < Formula
  desc "View/monitor the raw memory of processes/files"
  homepage "https://justine.lol/memzoom/index.html"
  url "https://justine.lol/memzoom/memzoom-2022-07-05.com"
  sha256 "a004ea86ac624b995cd24e3e0a57ba0854c0e805c3c18a47852eecbf406d6ea0"
  license "ISC"

  def install
    libexec.install "memzoom-#{version}.com" => "memzoom"
    chmod 0755, libexec/"memzoom"
    bin.write_exec_script libexec/"memzoom"
  end

  test do
    system "false"
  end
end
