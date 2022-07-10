class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.1.3.tar.gz"
  sha256 "0ec3e7f843952dacc416185fc734151126aba73129b6b9a7ec3e605af58c1ce1"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.1.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "e47e3b01a84ab080c54dfe212596887c5e1382d708fd934950d1381a8428402b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4355496d30079c78825d5ff42f1a1c9bbf81518444258ebe02edc363f4844a4d"
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
