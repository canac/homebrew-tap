class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "396eee7d21e0389a9bdf645e59973e7270893245bf39e48f39a7708cafe6bc75"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "55fbe1c0e73611d2b7dd950227b17a0c9cd5982650491eeb752c62e84614a59e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9e6ff0982921d44b41e019550fb31f655adc8f43e34dfed860407e0a05dad920"
    sha256 cellar: :any_skip_relocation, ventura:       "b8a92115ea7f47a74651f9c53f3e2078d74d1bd28803006f756d086e799f0269"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b261d5a7dce719659f98d194fd3921c2a4d87ceeed26bf962812429b52f584c"
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
