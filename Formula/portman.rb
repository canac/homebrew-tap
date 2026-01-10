class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.5.tar.gz"
  sha256 "72f940783b4c95fe9a5dedd08d6a57027f0854e22916d4e77f7b1b9bbbfc17ec"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6d9eb3523c27925ec5ed787dca0cf6481d79cab2a1fe4839597decf0e174a5c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fdc558a68d258182b24a48161f863139f147a5ea41ef8d171507dd40a648e474"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa71e8f2cee5cc9f9921771bb821714d7fc327483af29491d6566722e82a5c9d"
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
