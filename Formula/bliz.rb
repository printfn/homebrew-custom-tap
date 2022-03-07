class Bliz < Formula
  desc "Incredibly easy, interpolated server-side scripting for Gemini"
  homepage "https://sr.ht/~cadence/bliz/"
  url "https://git.sr.ht/~cadence/bliz", branch: "main"
  version "0.0.0"
  sha256 "6e0d5237bc1de2a42ba1cf1a5c1da7d783bd9da06755e0c7faba6c3ba77ab1ee"
  license "AGPL-3.0-or-later"
  head "https://git.sr.ht/~cadence/bliz", branch: "main"

  depends_on "fish"
  depends_on "nmap" # needed for `ncat` command

  patch :p0, :DATA

  def install
    odie "This formula must be built with --HEAD" unless build.head?

    # install main files
    libexec.install "main.fish" => "bliz"
    libexec.install "certs.fish" => "bliz-certs"
    libexec.install "src"
    bin.write_exec_script libexec/"bliz"
    bin.write_exec_script libexec/"bliz-certs"

    # install default configuration files
    etc.install "certs" => "bliz/certs"
    etc.install "personal" => "bliz/personal"
    etc.install "serve" => "bliz/serve"

    # ensure that `bliz` can find the new config locations
    libexec.install_symlink etc/"bliz/certs"
    libexec.install_symlink etc/"bliz/personal"
    libexec.install_symlink etc/"bliz/serve"
  end

  def caveats
    <<~EOS
      Certificates can be created with `bliz-certs` and are stored in:
        #{etc}/bliz/certs/

      Content will be served from:
        #{etc}/bliz/serve/

      Configuration files and scripts can be placed in:
        #{etc}/bliz/personal/
    EOS
  end

  test do
    sh = testpath/"test.sh"
    sh.write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail

      echo -en ".\n.\n.\n.\n.\nlocalhost\n.\n" \
        | openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 10 -nodes
      timeout 1 bliz || true
      killall ncat || true
    EOS
    assert_match "Looks good!", shell_output("bash #{testpath}/test.sh")
  end
end

__END__
--- main.fish.orig
+++ main.fish
@@ -1,10 +1,12 @@
 #!/usr/bin/env fish
 
+cd (dirname (status current-filename)); or exit
+
 source src/config.fish
 source src/includes.fish
 
 if not test -e certs/cert.pem; or not test -e certs/key.pem
-    echo 'You need a keypair for the server. You can run ./certs.fish to generate one.'
+    echo 'You need a keypair for the server. You can run `bliz-certs` to generate one.'
     exit 1
 end
 
--- src/cgi.fish.orig
+++ src/cgi.fish
@@ -121,7 +121,7 @@ if test -f "$file_path"
     if string match -q -r -- '^.*\.(gmi)$' $file_path
         set mime text/gemini
     else
-        set mime (file -ib $file_path)
+        set mime (file -b --mime $file_path)
     end
     gem_header 20 $mime
     cat $file_path
