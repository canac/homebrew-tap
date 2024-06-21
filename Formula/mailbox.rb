class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "b8234c55a82369385c7756a9561e4d37bbd3c8308b34efadda358444b157b1c5"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "82d1e05a89ac7f52cde40ee40095a1ea2887f5a589a85a4af2e7dc8620cc3b91"
    sha256 cellar: :any_skip_relocation, ventura:      "0cb688d69d727c793b79217a019a31227b51eaa4cb961705d96a4c7b3b68136f"
    sha256 cellar: :any_skip_relocation, monterey:     "b186e7e824303845bd4c7de8bb2d179f5335767c874f82589388d8cbfe7e30c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "67b20a851edfe77a95a0fafbcfb064d7ffc6b5ad3e363df40d93bd56957da5eb"
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
