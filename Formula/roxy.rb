class Roxy < Formula
  desc "Scriptable man-in-the-middle HTTP(S) proxy using JavaScript web-standard APIs"
  homepage "https://github.com/canac/roxy"
  url "https://github.com/canac/roxy/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "103f27a7fe25bb9062ca6c2e3932ec28c98fefc8f98a90cefb82b78b4397f46c"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/roxy-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "af0bb470e6444db0c041e2ed88f31425529fc8bc052e42828c3e6fdbcd382de9"
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roxy --version")
  end
end
