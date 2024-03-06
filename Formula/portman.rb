class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "2165874d95bdc9fc854ea2c54b05494a3e8296f481edfe73dacd5dc103ec7423"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9442d2540af76dace0dd5c9a6d67da9da87c6c1a9c27231b3177607ef088077a"
    sha256 cellar: :any_skip_relocation, ventura:      "bf267dd95c6add78b8108d559ea08a0f68ce65844da17942ef4a17bc9771337b"
    sha256 cellar: :any_skip_relocation, monterey:     "f57930ba9f40a5fe2c23378861c212052e832076bc931f3ea81b596582cbbf51"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f58cdbe4c521620799a6516abf0b40c42514cb97538dfa18a69231e67fec77a6"
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
