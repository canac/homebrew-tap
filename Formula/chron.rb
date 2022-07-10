class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/v0.1.0.tar.gz"
  sha256 "98124249c0a760ac2a1ed9bc4a0ed7037b92a073a119ac0c7d6d30641849a90c"
  license "MIT"

  depends_on "rust" => :build
  depends_on "mailbox"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "test", "-f", "#{bin}/chron"
  end
end
