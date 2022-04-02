class Portman < Formula
  desc "Local port manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.2.0.tar.gz"
  sha256 "d71ae0f6940c2f9cab202ae1e2da98031ed13922e2b69ddae51b2ff594c9402a"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.2.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "b53bfa08583d947841fd908c30412a91bcf3566983fec778285086a1a941cafa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b9bbfaf704321105f5c98a5356077344d8804693f46c8075fa46c80d7c32548"
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
