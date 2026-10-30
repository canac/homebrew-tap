class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.6.tar.gz"
  sha256 "3fef5a4ab01757a772898cc3533f28db20235cb4d60cc83552f8a51ac2ad19dc"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0928b1ddbc0a734739d488990a6fb8b736d609f1d787e75ed10ddcf3838d4c13"
    sha256 cellar: :any,                 x86_64_linux: "cbeac0f0076899d226d691e554f67607ffad7c8ac1e4ac145bdd3eec75db1268"
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
