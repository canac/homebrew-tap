class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "63c47e31d8d7194342dc074e4cc1ff61b243378f4487aff4ed4dfad21df51843"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fec6167d518f47e3bd4574868c0f8b0cc7a3e48857c1d37e803cf5dd3bb34ef0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2b02d14c91b3f0ede131287c7ba64214d05fa71e757310dbdd6a6bc012263ea7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "797dbaea9838d4d35e65ba0b8c1b82363855942d74cea43087eecc680cacf6db"
    sha256 cellar: :any,                 x86_64_linux:  "e6cc39d062f28870a63dffaa8adcbdd1745169359154ae3bb317788ed6f33b93"
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
