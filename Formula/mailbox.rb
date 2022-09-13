class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.5.0.tar.gz"
  sha256 "206b81b8d939b06e1b93ea61753a0e5664b1e44ab9e96f5438231d55d8d1ab10"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "b7cc8a72db29efae8adc2bdbd71297749979ba8438845f786061998fcda07669"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b5388008e4bf5315e5abdb0978c84297c3d67c79720a1b504b798d98a6e8b1e8"
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
