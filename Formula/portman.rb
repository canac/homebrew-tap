class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.3.3.tar.gz"
  sha256 "63699900658f359be1311ec71175087eb6af759e9c21855117a2c5e8588d4a33"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.3.3"
    sha256 cellar: :any_skip_relocation, monterey:     "09e84628fd48f65c43c52dd5ccbc544b9de11552056d0649ee55520ab39c7a33"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9ad7a8aa1e6f5af3243c94af854ca4b1e3c5bcfd223a13b13a68fed52433f391"
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
