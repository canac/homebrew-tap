class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/v0.2.4.tar.gz"
  sha256 "a20ced573f385a3d00cc21cc2c3fbc233ed86560db264a589f06d27cc4a29ccf"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.2.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "215b7e3e9a1732487689e76df7b52b2342ebe1b0db31677054f9f9f57e7d20cf"
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
