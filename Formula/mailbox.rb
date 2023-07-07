class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.7.0.tar.gz"
  sha256 "554d78d0219222202f172d09f4326723bc10f925924b15ece86e6a80de618eaf"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.6.1"
    sha256 cellar: :any_skip_relocation, monterey:     "988b6111d7e73de44284be889d358e45479af84f89c42d235ad6939d94041f3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1602434a12dcf279a29cda662febf141a8e445d755939dba91983adf473f5bae"
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
