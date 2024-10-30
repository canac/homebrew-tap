class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "396eee7d21e0389a9bdf645e59973e7270893245bf39e48f39a7708cafe6bc75"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "722632477b26c71920092714da94452e519edaa523c425e5ab8316a9ddd11986"
    sha256 cellar: :any_skip_relocation, ventura:      "e57cb3d05627eeae28f1221844ebb526eb6e14a6f5c702e5db72dbe92885c5c1"
    sha256 cellar: :any_skip_relocation, monterey:     "16ca389426d042ae4ebe24f276b2716018b5dce87ead4cad1863fa1200ddf47f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a2e11984bb5f98d30e0a0ddfe5a63a74e5fb4e402673c1effcad4d56e8a36360"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "cli"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "server"

    man1.install Dir["man/man1/*.1"]
    Dir["contrib/completions/*.bash"].each do |path|
      bash_completion.install path => File.basename(path, ".bash")
    end
    zsh_completion.install Dir["contrib/completions/_*"]
    fish_completion.install Dir["contrib/completions/*.fish"]
  end

  test do
    assert_match "bar [foo]", shell_output("#{bin}/mailbox add foo bar --no-color")
  end
end
