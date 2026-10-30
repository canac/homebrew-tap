class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.8.tar.gz"
  sha256 "d860f00305273a8650865a9e064a8eda9c3a98e4e6d8b1fb5e937be58902346b"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "fa42cc7ac874f81c10eee6bae023dd52ddbbd0d5eee5e7d07813ada44c336328"
    sha256 cellar: :any,                 x86_64_linux: "0df2d4ad298891d5b1cf54eef5f432a0d215383298a7ec0addd082db7fabcd22"
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
