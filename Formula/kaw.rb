class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "e4eaf683f7f89f9423f76cd12ea4c0719da43ceef59ec5d479af635e4b8cad66"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "697a1b5039ec7d179687b8840be1f3faf434b7c838c30be9d6170d73d365eb12"
    sha256 cellar: :any,                 x86_64_linux: "46d87c34884c630b7de933bd62d858684122ccfa5ae5b08d5a1d271dacf08cc4"
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
