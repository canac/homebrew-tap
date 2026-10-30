class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.8.tar.gz"
  sha256 "d860f00305273a8650865a9e064a8eda9c3a98e4e6d8b1fb5e937be58902346b"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "60e3943594838f3d3a42f7a96c093601f7de7f10c03e2a8dad9a8bef074fe01d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7835ed43ce17beb1d6e8ff970e19b5da56355261489ae1618df781d7b5114e31"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9982196a6acdd04a4ff0e8492eaf9135961e8154de4ba2778aed8dde295659d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8ad27d44b34e48aca4e2cf89766894238f58287e4cb2c62a15505b7a2a1df9e"
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
