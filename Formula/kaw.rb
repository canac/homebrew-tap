class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "9a4eee0289f68cbd96146a1a557eaf6254668e38d0aaa3b3921256526625d83c"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "78fbe5036304bdc741957fa7e25b47e0e4a8c2c75dd94299dca96c2c41474f4b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a22656ab7ca7c1f3abe822ec334e347e33f81bd188d8c9699257071e5607401f"
    sha256 cellar: :any_skip_relocation, ventura:       "e52bbc43662dcd60b1232647a0cdfc216908b28b402030311a2e3f49d578efce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1219e00358356439da491ee63f20cfe8f5e5645781cababc5f86aa926b0c9945"
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
