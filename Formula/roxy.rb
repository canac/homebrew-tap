class Roxy < Formula
  desc "Scriptable man-in-the-middle HTTP(S) proxy using JavaScript web-standard APIs"
  homepage "https://github.com/canac/roxy"
  url "https://github.com/canac/roxy/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "62e1fbbc352984935bfe97d42a22a0017348e4ed16c1ef7f805eeff337a37173"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/roxy-0.1.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "77f71ca12ac96ff8f77a346c17fa321dc80dd15b7bdcc6ef3e30cde10bf896cf"
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args

    bash_completion.install "contrib/completions/roxy.bash" => "roxy"
    fish_completion.install "contrib/completions/roxy.fish"
    zsh_completion.install "contrib/completions/_roxy"
    man1.install Dir["man/man1/*.1"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roxy --version")

    (testpath/"hook.js").write <<~JS
      export function onRequest() {
        return new Response("hooked by roxy");
      }
    JS
    port = free_port
    pid = spawn({ "ROXY_PORT" => port.to_s }, bin/"roxy", "run", testpath/"hook.js")
    begin
      output = shell_output("curl -s --retry 10 --retry-connrefused --retry-delay 1 " \
                            "-x http://127.0.0.1:#{port} http://roxy.test/")
      assert_equal "hooked by roxy", output
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
