class Portman < Formula
  desc "Local port manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.0.4.tar.gz"
  sha256 "4b9b5f82d90d929088ca668be7c95dde3d8e3b229fd4a5a8523fcd640a335931"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.0.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "26dd8ae99a75845213f8ca919b26182f05f1ee1cfc6f778a3c575d16ebeabcc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4652af6d0782efb0b5ec23a0136ff8be9cb1d6f2b1c307750205654a74501ab4"
  end

  depends_on "rust" => :build
  depends_on "caddy"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/portman", "--version"
  end
end
