class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "f4f57b9b81238185bf6e6aaaeeb0296dfe44bfb3800197ca013d11b744f083d1"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3babb290bd27c19c7a3611e1cc447c2022e5b58895e58b4947d298fdc684a892"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "55648b27a8219be76959d48037e263c6dc1ad14fdef5ae7867846c44578baaad"
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
