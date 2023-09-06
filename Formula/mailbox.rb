class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.7.1.tar.gz"
  sha256 "b9c71d26725e2f7227f8cbbea2dfb9e46ce5eb58dd8161a80eb78b58bd008c66"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.7.0"
    sha256 cellar: :any_skip_relocation, monterey:     "b5bae7a6f5fef8faa5b1ca6e240f607d98d6dda19c44b6df1a7d769fa3a42e53"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce82f9723892c861d725b758fc0f0323141419643e364482bf70959c305d58e5"
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
