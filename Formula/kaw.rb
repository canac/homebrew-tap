class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "aa44dc2d7c613fdad8a1d9392f3ab646d0ce08b2f903d3a00e3bee46adbbeaef"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a89ae8ba86272085f0374dc5c6f360cf2a3c05304caa4d6dce22938087d1b5b2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8eab83b3b0d1a10c69f556ef47e3364bb68643bd8d156b032f7759552d091719"
    sha256 cellar: :any_skip_relocation, ventura:       "80e3ff248ac9ffd55c27a71a55eb9f0c225c4a10995c0efef47ca0d8603312c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01f93697c22ed5843802a3e199ca55562a624d833cdc9cec17b4598114dce099"
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
