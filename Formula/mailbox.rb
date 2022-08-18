class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.3.3.tar.gz"
  sha256 "43a38a457efeeb89982bb29631d3cf71690e2092d119f5b175390730a5f5c7b4"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.3.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "ad3a984d7b13fd4a3828f1b43869a68fab78b0cb246d494ef123e9b68646eae4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10f21238dd3a0ca550a1a72e7393069c5b8407fa7d14ca2b03ad97f6d85a7bce"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    man1.install Dir["man/man1/*.1"]
    bash_completion.install "contrib/completions/mailbox.bash" => "mailbox"
    zsh_completion.install "contrib/completions/_mailbox"
    fish_completion.install "contrib/completions/mailbox.fish"
  end

  test do
    assert_match "bar [foo]", shell_output("#{bin}/mailbox add foo bar")
  end
end
