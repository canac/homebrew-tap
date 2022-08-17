class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.3.2.tar.gz"
  sha256 "1a8c072f612f474ced6c83e708812f25a92d98798750467a949ec317b1f1d57f"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.3.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "02a3d4d56694d76d107e7bd7be0fc82c9b49d00968dc34cd83395d8b4c6c2347"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af53bb7d39c35d49c06c1bed62ef4e9b1f5a3b28f2f45628c392724de2115f6b"
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
