class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.2.0.tar.gz"
  sha256 "fda4a8fe839bbf56aa4e1e71922273690fa9d9cd4a927d3fc9089d3f8c9347a5"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.2.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "f79d5ed3b73e36f8243bab2710488605f21a9a3bec8c8f07d0fba7a9d11653e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e1d866dd0ba2625cf7bf85f6fc8503b9214bd441a153b12cd24900ea623bf787"
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
