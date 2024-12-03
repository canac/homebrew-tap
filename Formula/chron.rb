class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "3556c2e12c3e2e8286f4be31c190dc45b572bcf4c359bf5e136666ae15aab655"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.3.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e5ad1e853a77d92360caf2f9d1859ad83cebdec77eb69b008defe2f62b877d67"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "27ef210f58cb135d9c54f4e4c1b31b62df4776f85a77ccdccee55e67066655a1"
    sha256 cellar: :any_skip_relocation, ventura:       "fec4a0926a930dea566a962d0f9b80018b09f78dba06d82cfcd6cd4fe2944ce1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66ece30f55c6b3f09ac5e3cf34671a56e8e98f26b5c196b2a90d0c66fc5b4d80"
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
