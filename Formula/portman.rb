class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.2.3.tar.gz"
  sha256 "0dd747fc82764a4c1c0b6f0b5453e12c26f984e95ca1b4f2aec61268cbe044bd"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.2.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "a97082a0a58d55c2170859ac0bb3c20b52eeb8acb26b207cf01341e0f9af21fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6d3b04b0435908690e4aa9dc8bfd4f58a103a28af59d808fd9856864c38bc30a"
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
