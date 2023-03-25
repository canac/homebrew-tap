class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.3.3.tar.gz"
  sha256 "63699900658f359be1311ec71175087eb6af759e9c21855117a2c5e8588d4a33"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.3.2"
    sha256 cellar: :any_skip_relocation, monterey:     "8e27b946caaf1c76a09320906beedb4a765f82a9f07d982730363968402144ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec63ad92feaad432ba3ed5b74b239bf8dbd6ea02f0994b2c58584c7c30d96897"
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
