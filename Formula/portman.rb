class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.3.0.tar.gz"
  sha256 "8d558b17a7b2818d41cc2d1c92e96678aff5caa422842e56bc1752585cc229ab"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.2.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "9b840b197354a171f14f89e0810cdcace8d2d0de27bdb3ced79d874679d497cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b49aae604be18ee9d2dfcb9436fc2ce4a8402d9d52279e1d8105bebb9621a9f1"
  end

  depends_on "rust" => :build
  depends_on "caddy"

  def install
    system "cargo", "install", *std_cargo_args

    man1.install Dir["man/man1/*.1"]
    bash_completion.install "contrib/completions/portman.bash" => "portman"
    zsh_completion.install "contrib/completions/_portman"
    fish_completion.install "contrib/completions/portman.fish"
  end

  test do
    system "#{bin}/portman", "--version"
  end
end
