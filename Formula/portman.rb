class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.2.1.tar.gz"
  sha256 "c2ed5d685a140027c117783997c35b3f407f923efc008d9ba795b38f2ec28136"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.2.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "2e8a1790ffb2dedd1e3b3fb44e50d3f8e2c35035e7bb133c3e76fd9c2c66e6e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "db71212d8e8be2f7bcd1036f151e70910fd855fd7db9fd7810404bcc43d7431b"
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
