class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.2.0.tar.gz"
  sha256 "fda4a8fe839bbf56aa4e1e71922273690fa9d9cd4a927d3fc9089d3f8c9347a5"
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
