class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.5.tar.gz"
  sha256 "cf531b4c9e93bf5a6086d1ff88bee73e867ce37a5a1d26775008fa394b932bc6"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b51e77e7f6f9b5675f67dd1ec5d8b2521214bf1f132f288cb703f97caebfbd48"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "27831dc2d58d897e43d29fb5487e08291a624cc6c88c7443776f80f2ffec5606"
    sha256 cellar: :any_skip_relocation, ventura:       "e579d2dbe2f696361b01c577aa5cd0a0da47f9de1f612ef738991ddc47a7ea64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb60c7ae5d1396baa12b5d946cbd7232888a21d1aefd3bff70f184f6f97604f0"
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
