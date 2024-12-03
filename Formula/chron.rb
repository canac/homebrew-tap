class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "3556c2e12c3e2e8286f4be31c190dc45b572bcf4c359bf5e136666ae15aab655"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.3.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f9e628e8856ff0c6786d3b3248d8b25f10fd5fbf3fdc954ef829caf6bbc82d3e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dee243f32cd6a7ede02ba5b7d9174052a1f6bd85b03749c5435a869c53ac18ea"
    sha256 cellar: :any_skip_relocation, ventura:       "afa122d0328d7083050a8422fdc3d68928357de48d2e39baae3804f138393620"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad529c3d326a115e24b44de55ced6a26c3c20a6ab2ed091e829739982ae0c679"
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
