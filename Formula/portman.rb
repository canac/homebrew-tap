class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.3.1.tar.gz"
  sha256 "9d2c0da86659fc6f2fe01fa299c67808e6a84b2609308fc1fe2b97a88bc39a22"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.3.1"
    sha256 cellar: :any_skip_relocation, monterey:     "56451d584acd539d3aff3af2be4d81fe7112b613fab043dd6b0261f05b6eae6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "150164b4dc917b0e35997a5b64556bb77d5a4d37048b1e93481603b93c0a93ab"
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
