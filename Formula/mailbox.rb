class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.7.2.tar.gz"
  sha256 "44ad8ec24d0597d86726618008f0f829ab6687507516ba79bc2bcacd2adb423b"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.7.2"
    sha256 cellar: :any_skip_relocation, monterey:     "8387bb031dc0df160b2c4f71fa2a134265383d8e0e9ffd1823e7ee467317e5c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fd8433ece05ce4823b8be2ab545b2a3c2342100d014681105ca52c4defcf81c5"
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
