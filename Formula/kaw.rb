class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "b4d2c18add2b5012ff65ad215e08c243025f163f6aa741b3240a0c5d946e3a28"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "df10ed4226afb33a1849f942279ca37e513af2a31bbbf8163d63cbed27b5c952"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e07707b10cc350c5903178439203b009cb935ea4df585318ed7dc2da619d4489"
    sha256 cellar: :any_skip_relocation, ventura:       "81351e9ee3ecc74b30553ab98e76c8ee1e82d3854852a595badeca08019407a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "764753a050524a652f702beeb10cd7ab823b04ed849a37f1a079ba3db1db6981"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = pipe_output("#{bin}/kaw 'stdin.take(1)'", "1\n2\n3\n")
    assert_equal "1\n", output
  end
end
