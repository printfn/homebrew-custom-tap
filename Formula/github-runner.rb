class GithubRunner < Formula
  desc "Official GitHub CI runner"
  homepage "https://github.com/actions/runner"
  url "https://github.com/actions/runner.git",
      tag:      "v2.295.0",
      revision: "78d13b4c96e0857c1323febcb0cac7d8f5cf5822"
  license "MIT"
  head "https://github.com/actions/runner.git", branch: "main"

  def install
    cd "src" do
      system "./dev.sh", "layout", "Release"
      system "./dev.sh", "build", "Release"
    end

    libexec.install "_layout"

    bin.install_symlink libexec/"_layout/config.sh" => "github-runner-config"
    bin.install_symlink libexec/"_layout/run.sh" => "github-runner-run"
  end

  test do
    system "false"
  end
end