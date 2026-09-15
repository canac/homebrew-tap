class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "7cc53b65875458bfb7bde6d078e089f7c67059ed41b274923f536287b7c9bbe0"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6665611cefbccca9fd7c861ea8c811bcf82ff23ec17d69838d10729e4f185435"
    sha256 cellar: :any,                 x86_64_linux: "3d8b671858ec40a84db04571096828f59098e4534d6b40ad96cea4940ad56731"
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
