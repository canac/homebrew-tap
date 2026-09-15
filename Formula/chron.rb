class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "807fb3ec57422e3ea24ac2d7abe7c611dadc7a9878e358fabdc1ce4956de32a4"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3a2922a1751397b6a75bd080325b5668f5636b86e29dbca28c724a13d70991b7"
    sha256 cellar: :any,                 x86_64_linux: "e5d8688b4ea9e3b3c9dd5d8d25d7e13da4bc112b155d44b7536e07712139c4d3"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    man1.install "man/man1/chron.1"
    bash_completion.install "contrib/completions/chron.bash" => "chron"
    zsh_completion.install "contrib/completions/_chron"
    fish_completion.install "contrib/completions/chron.fish"
  end

  test do
    file1 = testpath/"file1.txt"
    file2 = testpath/"file2.txt"

    (testpath/"chronfile.toml").write <<~EOS
      [jobs.file1]
      command = "touch '#{file1}'"

      [jobs.file2]
      command = "touch '#{file2}'"
      schedule = "* * * * * * *"
    EOS

    fork do
      exec bin/"chron", "run", testpath/"chronfile.toml"
    end
    sleep 2

    assert_path_exists file1
    assert_path_exists file2
  end
end
