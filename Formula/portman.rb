class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.2.3.tar.gz"
  sha256 "0dd747fc82764a4c1c0b6f0b5453e12c26f984e95ca1b4f2aec61268cbe044bd"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.2.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "61e8ea5322d8345d4c46e85e6c22ee0e5b7be912b8d29970ac4e6ecf71c0d342"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9d635395da3d6b1de17cb917b4db054925cfee3d79ce4400dfd8537d4ba6d8fe"
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
