class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.3.4.tar.gz"
  sha256 "769050fdcfc7b9a2ae2e8456d2add8e94e77b5f4a3b68a062d6d8bcbbaae7997"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.3.4"
    sha256 cellar: :any_skip_relocation, monterey:     "282d6f3ac95f8756d176ca57665533e11deabac6ad020b7177bbcb3812767c08"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "62333a72fc09e623bd44d74a21a90c0a957149894b42883147edd7e4a68eb2c1"
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
