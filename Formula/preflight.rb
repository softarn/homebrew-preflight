# Formula: preflight.rb
class Preflight < Formula
  desc "AI-powered code reviewer CLI"
  homepage "https://github.com/softarn/preflight"
  url "https://github.com/softarn/preflight/releases/download/v0.1.0-alpha.1/preflight-0.1.0a1.tar.gz"
  sha256 "8350255cbbadfb9a4e9275f1eefce9a4227a870af1d3f1975c6dd4ddb316802b"
  license "BSL-1.1"

  depends_on "python@3.9"
  depends_on "poetry"

  def install
    # Tell poetry to create the virtual environment in the current project directory
    system "poetry", "config", "virtualenvs.in-project", "true"
    # Install all dependencies
    system "poetry", "install", "--no-interaction", "--no-root"
    # Copy the entire virtual environment to a permanent location
    libexec.install Dir[".venv/*"]
    # Symlink the executable into the user's PATH
    bin.install_symlink libexec/"bin/preflight" => "preflight"
  end

  test do
    # A simple test to ensure the command runs
    system "#{bin}/preflight", "--help"
  end
end