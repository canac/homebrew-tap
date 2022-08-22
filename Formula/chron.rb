class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/v0.2.2.tar.gz"
  sha256 "3981a778e013dd2fe921c14ff84bc758068a0ede0aca09e986f89e2e10fe8cb7"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.2.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "e0d27e316e9a303abb0e6aff41bdef485f977663237505a4adaac06794e51f8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f4d17c2e2731a577c7f896fe343067b546849c49c66ef11bf781db4bb3dc6328"
  end

  depends_on "rust" => :build
  depends_on "canac/tap/mailbox"

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
      [startup.file1]
      command = "touch '#{file1}'"
      keepAlive = false

      [scheduled.file2]
      command = "touch '#{file2}'"
      schedule = "* * * * * * *"
    EOS

    fork do
      exec bin/"chron", testpath/"chronfile.toml"
    end
    sleep 2

    assert_predicate file1, :exist?
    assert_predicate file2, :exist?
  end
end
