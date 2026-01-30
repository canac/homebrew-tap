class Kaw < Formula
  desc "Transform stdin like awk but with expressions written in JavaScript"
  homepage "https://github.com/canac/kaw"
  url "https://github.com/canac/kaw/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "e22f93f1bd87a59bbd588cf309e8174fbc33e473f3343f3e2c3f9bc0fabb61b6"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/kaw-0.1.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "87b8dc2f7f69f9bcc9686cc327107398058030545971976d4dc1eab044e8551b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3f435deaea6c2afe073ff0fd1bc95884d4bfc47376760cd8e5d72e8aef9e5ec7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e47cfbda6d6c86a0ed4cfebfbdc636d0ec42e04f7ffd4386ccc9bb8c38bc8348"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "77bbe71b6ff9682ac62545ed207225d6d7094bea8a51a0ab12fdc84843ab5549"
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
