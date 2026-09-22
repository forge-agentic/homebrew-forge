class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/forge-agentic/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.24.tar.gz"
  sha256 "173d9d10ba6fc6bb72b137ba7a0f1539bf0fce26b10e05710682f75625cb3d0e"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "ci"
    system "npm", "run", "build"
    libexec.install Dir["*"]
    node = Formula["node"].opt_bin/"node"
    (bin/"forgecli").write <<~EOS
      #!/usr/bin/env bash
      exec "#{node}" "#{libexec}/dist/cli.js" "$@"
    EOS
    chmod "+x", bin/"forgecli"
  end

  test do
    assert_match "build", shell_output("#{bin}/forgecli --help")
  end
end