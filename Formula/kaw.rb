class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "b4d2c18add2b5012ff65ad215e08c243025f163f6aa741b3240a0c5d946e3a28"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.4_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a09cdd86ed9f06c14f917b9b41343d896cfcaa0f45fbb2f25205c407cd988271"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "65820211b49c764a77e24744188c71dbefd55aa085e34ec1fd5f658288b4195f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "20864741b4f482b13136abbab8922ceabda38f1d2bea1b17ec8a8c46ccaede96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7c5fc7f3597e4d131c9d040fbaa6151271d76321d6a33645552ef28c03fe7ea6"
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
