class Roxy < Formula
  desc "Scriptable man-in-the-middle HTTP(S) proxy using JavaScript web-standard APIs"
  homepage "https://github.com/canac/roxy"
  url "https://github.com/canac/roxy/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "b89a12dcc2a11c19d83639c1d8cc45db303810a813683485ca18b123ecf85585"
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
