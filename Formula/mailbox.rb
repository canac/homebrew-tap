class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "b8234c55a82369385c7756a9561e4d37bbd3c8308b34efadda358444b157b1c5"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "1631684ef6d0568c7bad6028df7187fc8fff10d4fe2d7a3b2a631ad8521320db"
    sha256 cellar: :any_skip_relocation, ventura:      "7ec26ec66fce0c290e6128d9beea7deec562f6fe375b260c79f6929e1aa589d0"
    sha256 cellar: :any_skip_relocation, monterey:     "4e301fd264e28b75c910cf6a3b15f29d30efe094e547b0602140e0787d344f6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b1698e45900a2d7cdac7bbae640b5dbdafef9416461e6937bc5bbea4aeb1aa0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "cli"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "server"

    man1.install Dir["cli/man/man1/*.1"]
    bash_completion.install "cli/contrib/completions/mailbox.bash" => "mailbox"
    zsh_completion.install "cli/contrib/completions/_mailbox"
    fish_completion.install "cli/contrib/completions/mailbox.fish"
  end

  test do
    assert_match "bar [foo]", shell_output("#{bin}/mailbox add foo bar --no-color")
  end
end
