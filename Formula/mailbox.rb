class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.5.2.tar.gz"
  sha256 "cc3bf524e06edf2987f6beab09ebd41a02f79ecdc3310b9a62690ce1aa4c7669"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.5.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "4d16809c68c339924aadf7e439f3aaa56025687658cb629db3476af00a8f10b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9ccaca2fe705a60c2747437ec9a934c38a9dee7dfdabdc1a8342dc8dd8e51476"
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
