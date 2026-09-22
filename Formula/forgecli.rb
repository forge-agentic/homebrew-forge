class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/forge-agentic/forge"
  url "https://github.com/forge-agentic/forge/archive/refs/tags/v0.2.25.tar.gz"
  sha256 "b29e8e7eec72424e99dce9cb5974ed2c9460a3ab8790e13aed0ebae6ef9626fa"
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