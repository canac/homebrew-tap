class Portman < Formula
  desc "Local port manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.0.3.tar.gz"
  sha256 "92661449d100d3f20de763add5531a90eb1cf3b17b1cd417e3a889f7fcf54425"
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
