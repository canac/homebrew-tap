class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/v0.1.1.tar.gz"
  sha256 "2598cca4d407e047edf84a4fd47fbdbcb57321537e1ec4bb5227d542107adfd3"
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
