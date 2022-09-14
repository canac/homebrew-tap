class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.5.1.tar.gz"
  sha256 "afaa7988861dc02c0e022aa447c31cfadc847868fb721c26623f0fdfecf0334a"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.5.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "8a3b06c92b9f57a290c1e79df060b7ce70bf12737f3794df035a47d26783d301"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9bebd2fed738fee153a527b917bd4b87c90c27505157777eafc575f49436b54f"
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
