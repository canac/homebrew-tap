class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.7.tar.gz"
  sha256 "7bb4bd94ae3934030d5c4894946049cccc1a7513e2791f8dc3dc94eaa389c366"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4f83b5f6ea2eff3ac6b5cb6dbf07a6b1616d63dd9fee3938f2b649b0f268aeff"
    sha256 cellar: :any,                 x86_64_linux: "ac26f4603815f22e3eb7acec8aba571471e03d3778e3d242821e8e7ba27d2cb6"
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
