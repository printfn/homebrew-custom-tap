class Memzoom < Formula
  desc "View/monitor the raw memory of processes/files"
  homepage "https://justine.lol/memzoom/index.html"
  url "https://justine.lol/memzoom/memzoom-2022-07-05.com"
  sha256 "a004ea86ac624b995cd24e3e0a57ba0854c0e805c3c18a47852eecbf406d6ea0"
  license ""

  def install
    bin.install "memzoom-#{version}.com" => "memzoom"
    system "chmod", "+x", bin/"memzoom"
    #system "bash", bin/"memzoom", "-h"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test memzoom`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end

  def caveats
    <<~EOS
      Run `chmod +x #{bin/"memzoom"}` to finish installation

      To launch memzoom, run `bash memzoom`
    EOS
  end
end
