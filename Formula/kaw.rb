class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "b4d2c18add2b5012ff65ad215e08c243025f163f6aa741b3240a0c5d946e3a28"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "266527526c164d6617bc568ef5a26173720cde47bc8a9540c6760994571abdb3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ad11bcc9ee8adfe53875cf0ad315e7bc070780e2da9fc03db15d17971ddb0240"
    sha256 cellar: :any_skip_relocation, ventura:       "c9597d88309af17512c1d2e1dc97408ad0cef5885515e6090bbe356f3bc67705"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bca68bde8c05704729fae981de8893215c06b64962db0bdb87158ee7b190eaf2"
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
