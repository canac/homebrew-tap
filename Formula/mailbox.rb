class Mailbox < Formula
  desc "Message manager for local commands"
  homepage "https://github.com/canac/mailbox"
  url "https://github.com/canac/mailbox/archive/v0.6.1.tar.gz"
  sha256 "7cb75c3a8ad8fb892f0a218d9ac65023792caa4e11c83142fbdb2e7ef027ace4"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/mailbox-0.6.0"
    sha256 cellar: :any_skip_relocation, monterey:     "a2a046e1ba76e4c5e327a6a6f9dfbbed88a72a1a9858e6091ec0595913c11f92"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc53d2cff230a98f10c1ff3264625e191bae164c58cfca2cbcd9189e389eb57d"
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
