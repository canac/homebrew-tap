class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "29bd8b96aebebb7176f52b9f775098970c859e89a1b8298db980b875847bbec6"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8044b15d8f2a2168f4f449f642c3e717345c1d35f8a7d4eb731cda7968e1f800"
    sha256 cellar: :any_skip_relocation, ventura:      "c7e3578673a9a739f7c78eb7f6b9716f8d257d182c42813819a693b11b8ac000"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "48831329ed1cda6c2704fcd86c470e5b821178ea49c74775351ce0b7bbee61c5"
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
