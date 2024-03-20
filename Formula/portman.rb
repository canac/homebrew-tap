class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "898ff4b446552c0fec20a6414a5b343e66642bbebf70a26d5fbcf1be18cf4e13"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5234872fd7eec26f4bea6e6c1e3a01d8e6560a5d98970b3ee153ca5b9eedb2c9"
    sha256 cellar: :any_skip_relocation, ventura:      "65bfb6684cd3bfa56584d62e714eee63640770864141c66353106903eaabcc4f"
    sha256 cellar: :any_skip_relocation, monterey:     "b8611f3002480c6b255ce4ea26b968bed7748b5a06f486fab026957b1c96c7fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b0852d83f1ffadffeb7479980c58aa786c21d58f2707e003e4ea72ee18017d2"
  end

  depends_on "rust" => :build
  depends_on "caddy"

  def install
    system "cargo", "install", *std_cargo_args

    man1.install Dir["man/man1/*.1"]
    bash_completion.install "contrib/completions/portman.bash" => "portman"
    zsh_completion.install "contrib/completions/_portman"
    fish_completion.install "contrib/completions/portman.fish"

    (share/"fish"/"vendor_conf.d"/"portman-init.fish").write <<~EOS
      #{opt_bin}/portman init fish | source
    EOS
  end

  def caveats
    <<~EOS
      If you are using fish shell, portman will be initialized for you automatically.
    EOS
  end

  test do
    system "#{bin}/portman", "--version"
  end
end
