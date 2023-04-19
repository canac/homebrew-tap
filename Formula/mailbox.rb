class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.6.0.tar.gz"
  sha256 "4f3ae971f2b827109aa96c83164d1589d9c2628c8894249116cc3f854fb0da6b"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.5.3"
    sha256 cellar: :any_skip_relocation, monterey:     "a0bf703f595b50f30abb6e4bd9a9bbe4258ecff3c707cb1b144f6c4a72734bc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7e5d475fd2abecd031cb3dc8b0d1688419d1c8fe0f3e8ed079652756f32ce93"
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
