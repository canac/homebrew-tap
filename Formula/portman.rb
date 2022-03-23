class Portman < Formula
  desc "Local port manager"
  homepage "https://github.com/canac/portman"
  url "https://github.com/canac/portman/archive/v0.1.0.tar.gz"
  sha256 "03b79142fbd5c2211170d822b07983ab13ecaf9fb86db21f43913f53c612866a"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/portman-0.1.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "158b7d1cb2f4618149a68c938e2ee3a4b18ed0b70861427d22a56904f342374f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e173d916b8491f04cf42ff0484899b8e5db3f30cf8306bf295da8114cb923d59"
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
