class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.6.tar.gz"
  sha256 "4e40c495eb40ec0ea37bf12174aa3e39534e63e2d5768d901e3ab7e16f95ec00"
  license "MIT"
  revision 2

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.6_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e79323f5bb21a692f6f046d27f079a24c55c1add045f078416d4c5db683d5434"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "935102524b41a4b11c84aee93f3098949868ce05e77e7d46d4726ac8cbd3d922"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "389adef7989e7e24bd2cb0082c5c49c6d3df8fb56500802246750fb562299adc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c78ef7d9676edf9b5e030d8a7b9ecc522f75f8a2127a9c6f2a73d4e7ba53c18e"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "cli")
    system "cargo", "install", *std_cargo_args(path: "server")

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
