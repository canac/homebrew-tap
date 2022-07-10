class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.1.2.tar.gz"
  sha256 "329b6c29fde266fa87442959b23dd2e69706a91cb43a4beb9ad0951d82d99694"
  license "MIT"

  depends_on "rust" => :build
  depends_on "mailbox"

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
