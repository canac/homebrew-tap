class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.3.3.tar.gz"
  sha256 "43a38a457efeeb89982bb29631d3cf71690e2092d119f5b175390730a5f5c7b4"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.3.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "9983a9c1441341419b26866f28d708aa1bccae4465f063250c352f00db49f555"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fe24f29c02eca74a2c380aa7176745e34cc2638d7d32a0e2aba083c143b20448"
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
