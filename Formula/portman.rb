class Portman < Formula
  desc "Local port manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.0.1.tar.gz"
  sha256 "0f1ec02497283bdbcb3c174fec0f57e68efe29f4b2990550f1e53f679bd14c73"
  license "MIT"

  depends_on "rust" => :build
  depends_on "caddy"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/portman", "allocate", "foo"
    system "#{bin}/portman", "get", "bar"
  end
end
