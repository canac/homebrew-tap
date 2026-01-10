class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.6.tar.gz"
  sha256 "4e40c495eb40ec0ea37bf12174aa3e39534e63e2d5768d901e3ab7e16f95ec00"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1a5c7809ae7369093859a610bf50fa0bcf98fa8352cfe4af551e0a55595bc7bc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dd7baa1d02722f0e3f19f0d4f6b08297c7e3062eaa9556d0cdd0d6a932402c39"
    sha256 cellar: :any_skip_relocation, ventura:       "ab61f8ef3e90b5b492d7994df38ed929e40704aaf0454c52ed8e35acec4b7380"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2175d29af040b4df0a2866e8714f5d6127acea1d707c3a5a487b683bbd92f030"
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
