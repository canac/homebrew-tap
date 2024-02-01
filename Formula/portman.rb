class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "26ded110c01ba1a5a17e579f7f2e5b42b97501edfad5c59a95d25b97ac34ca83"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.4.0"
    sha256 cellar: :any_skip_relocation, monterey:     "620e188f64679d727f47558859a8fc465ebec2ac29faa20344f447f60625f972"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c65eedad82b7c556ea2580b0bc7099236c4f1e5ccf568b7125014e81c329934"
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
