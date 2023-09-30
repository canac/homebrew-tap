class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.7.2.tar.gz"
  sha256 "44ad8ec24d0597d86726618008f0f829ab6687507516ba79bc2bcacd2adb423b"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.7.1"
    sha256 cellar: :any_skip_relocation, monterey:     "f53d5456f9d29bfd70528643d165f8ebf6009c64b572cb26a5928710ba4cf9f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fef1269342990e61cd1f212979e46bb7f8759ba8e097c6e3b7f2bc75974fc904"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "cli"

    man1.install Dir["cli/man/man1/*.1"]
    bash_completion.install "cli/contrib/completions/mailbox.bash" => "mailbox"
    zsh_completion.install "cli/contrib/completions/_mailbox"
    fish_completion.install "cli/contrib/completions/mailbox.fish"
  end

  test do
    assert_match "bar [foo]", shell_output("#{bin}/mailbox add foo bar")
  end
end
