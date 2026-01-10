class Portman < Formula
  desc "Local port allocation manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/refs/tags/v0.6.5.tar.gz"
  sha256 "72f940783b4c95fe9a5dedd08d6a57027f0854e22916d4e77f7b1b9bbbfc17ec"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.6.5_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4d8ea47c3cee05ad40b48c4eb6807fe7fa88ca22276f406a0ebf135257e872e7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60b2571f2f31546e8ef79e21371588799e18982997cfb43a3e597a2ae654748f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "57637924ef52b1595deb9f1c668b3733e9d1df2b1b6810be630a636f97fac16f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58d8649dfa4db29a1d846624043fdecbf5dfe3d757c6f64afefdbc606f029fb1"
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
