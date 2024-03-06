class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "29bd8b96aebebb7176f52b9f775098970c859e89a1b8298db980b875847bbec6"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.5.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "12e01b96d4cadf6579b8c0a98a57302cf0bc0f794c92be42826d3e5746124568"
    sha256 cellar: :any_skip_relocation, ventura:      "d929e50dc127576b32c3d828839f31172dae914d8677ad2ac26be908b1fceb64"
    sha256 cellar: :any_skip_relocation, monterey:     "ff646128b5d55244435a9b49505a4cdf84445eb5d12366c900d199537e22da9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6e40f0109e873577a3fd60b3d212d83aefbf3b223f8f6a1104baf952f377d38a"
  end

  depends_on "rust" => :build
  depends_on "caddy"

  def install
    system "cargo", "install", *std_cargo_args

    man1.install Dir["man/man1/*.1"]
    bash_completion.install "contrib/completions/portman.bash" => "portman"
    zsh_completion.install "contrib/completions/_portman"
    fish_completion.install "contrib/completions/portman.fish"

    (share/"fish"/"vendor_conf.d"/"portman-init.fish").write <<~EOS
      #{opt_bin}/portman init fish | source
    EOS
  end

  def caveats
    <<~EOS
      If you are using fish shell, portman will be initialized for you automatically.
    EOS
  end

  test do
    system "#{bin}/portman", "--version"
  end
end
