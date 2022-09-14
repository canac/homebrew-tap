class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.5.1.tar.gz"
  sha256 "afaa7988861dc02c0e022aa447c31cfadc847868fb721c26623f0fdfecf0334a"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.5.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "57eeb6129e984351b57e03c7e6c8ff1533e4e30183ecb4c5935f09804e4e7d3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "afa6642923ff34e2cc2993dee0f9867c9c237d8a1b596e5b9d34f9fd5880fcc2"
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
