class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "97bedf9dcbd8712786662dcdb1a5f8007fe503c9d507e4925b1bbc0f66275750"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a9d8ef532894f0a6d405da25e0dae84591b3cfd21dadf8f8e98359fb4f6d510c"
    sha256 cellar: :any_skip_relocation, ventura:      "8fe9eaac4a0a59196848d9563d05733bb37ac981e160a6f70488b0105d53087d"
    sha256 cellar: :any_skip_relocation, monterey:     "7ded5da75a3d27eaafd5aae528b7cf928451c85309d02f7d7d401d579d4d03e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "481dcb161078c5e1e0bd8b844f37c555492959cb1a43fb52c593308e38701923"
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
