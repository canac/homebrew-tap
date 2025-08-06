class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "7a788cc429fa321f3cd22bce53a3eee158695e7d054a2188daec0faa7dde9298"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8df70b5d85cd738447323b6a20c8d08ba187e7154e0789ad7ced06efda8530ae"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1077234bc6856be7b7f795c0ea370002f5289d3ba3b16175c9d80492bfca5725"
    sha256 cellar: :any_skip_relocation, ventura:       "69670703c5ec98fe62ec35a976ba23de6cc5f0e60cbccb0b7fd2e794a64042eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e39cd79a9016ff1cc901b48291b23843f61b65be4507c54d508736a28683397a"
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
