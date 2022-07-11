class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/v0.1.2.tar.gz"
  sha256 "b85a6a184cd98d809ca647ce99f8daa40024335eda3307a2a5abb91e6cb3b639"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "b9339f2dc605e7044dd3f970db79e4d0f0c1940a5b1930377e928d0fb5083f2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "40f1aa64596f41e30ef3f3fd92ed42edd2deffa81354117165cc21de08c6c86e"
  end

  depends_on "rust" => :build
  depends_on "mailbox"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "test", "-f", "#{bin}/chron"
  end
end
