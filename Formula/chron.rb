class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "881ff325ef91760b87c2102ac5559c196b648b307aa801bc4cc793f91bb504e7"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.6.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "72061b4328ccb0059760dd23ab76f701fb6dcd57c623a0c8769ea91659fbf8a0"
    sha256 cellar: :any,                 x86_64_linux: "d1fdf24cdca6f8458f284bb3021d085a36320159e0f7c1822d7717b71bbcd68c"
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
