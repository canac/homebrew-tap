class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/refs/tags/v0.8.4.tar.gz"
  sha256 "20384c007d33031625b2b213eab6f2a64fc3d68d2abbfc70c75774d400b62f68"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.8.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "be0dafec3db7ee1f405d778744951f0adaff0507d61b3e6e498c2e039c43d67f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3012cd09964aebf791ef2f5d81672d52c8073f506beb70b7444c4a5bcb03d126"
    sha256 cellar: :any_skip_relocation, ventura:       "bb750df0bc39729fff7c849225e90b1ec50ca5694dde9ec789daa46fd74f4ccb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a64b375d410b55ad74c07aefbef7329076f5ddae9eb655b26fc96de039448331"
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
