class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.5.tar.gz"
  sha256 "72f940783b4c95fe9a5dedd08d6a57027f0854e22916d4e77f7b1b9bbbfc17ec"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "147df39ec123e6d5b4986a17799714145b5cffd57a97997363bac199930570ac"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3e13acc0693879417cf6aae623469ed2c8ab47608c8392b04b431e30481cabe4"
    sha256 cellar: :any_skip_relocation, ventura:       "79713c680c69472fa79c56a446dd00f69561fd20ebd32304ebaef11402397642"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9ee08cad88fa8c9ee4176065dddc0317b028243f367547183ca86095275b706"
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
