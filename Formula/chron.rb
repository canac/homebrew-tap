class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "cbd1fbc2237ef4a400699ac5647bae44f221fddae48c2581f2e9b8ad2dc08afe"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7b5d4a637e6fcac4540ce084f7d995b8c626959c88f624877f080b3ba05dd55d"
    sha256 cellar: :any_skip_relocation, ventura:      "97416634606594ff42cbf57762827e82d11264950dce32f8948d72eaf20e6825"
    sha256 cellar: :any_skip_relocation, monterey:     "d1184b828eb36a9d8c58b31b98decc2c2fedc8f5e80aa24c70b3975b1639a910"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "79ac70b1e900180900dc37eb26b2a66c2ef3e4bbcd50ae4e387d630583cca592"
  end

  depends_on "rust" => :build
  depends_on "canac/tap/mailbox"

  def install
    system "cargo", "install", *std_cargo_args

    man1.install "man/man1/chron.1"
    bash_completion.install "contrib/completions/chron.bash" => "chron"
    zsh_completion.install "contrib/completions/_chron"
    fish_completion.install "contrib/completions/chron.fish"
  end

  test do
    file1 = testpath/"file1.txt"
    file2 = testpath/"file2.txt"

    (testpath/"chronfile.toml").write <<~EOS
      [startup.file1]
      command = "touch '#{file1}'"
      keepAlive = false

      [scheduled.file2]
      command = "touch '#{file2}'"
      schedule = "* * * * * * *"
    EOS

    fork do
      exec bin/"chron", testpath/"chronfile.toml"
    end
    sleep 2

    assert_predicate file1, :exist?
    assert_predicate file2, :exist?
  end
end
