class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "e4eaf683f7f89f9423f76cd12ea4c0719da43ceef59ec5d479af635e4b8cad66"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "757d8d8b1f8add17634ea05f4d1f28344abd3ab89847b7b73f5b728246c9d2fa"
    sha256 cellar: :any,                 x86_64_linux: "8c214b23910210d5fefea39174b1029c9bc1985f4eed37ab511509f69d0b2afe"
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
