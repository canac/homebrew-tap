class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/v0.2.1.tar.gz"
  sha256 "b46bc44061de1d5471f338ef77750e65919658fafccc5ae80d158ee1ca823156"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.1.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "78eae8cb93bac2db6dbb9e647de5a7d1c2b6b1827774b51fc36de465316c5eb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "84db2ac913e0f7ff5a1707e42d4d679b3acb0958e9c2fdc0f2df2274ef5a8180"
  end

  depends_on "rust" => :build
  depends_on "mailbox"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "test", "-f", "#{bin}/chron"
  end
end
