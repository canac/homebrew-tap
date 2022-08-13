class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.3.0.tar.gz"
  sha256 "8755d76e259bde7672002d72c0050303942384191bcfc5b1df5ac6985cea6301"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.3.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "383e1e9a05acb4d24901aab06afd6e46d25992ac853996caae0be6853f7f8a27"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "08c11aab3596976340c13191a05d9bf7747b05f5c7e30b9fd984fea0c13f54c3"
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
    system "#{bin}/mailbox", "--version"
  end
end
