# Formula: preflight.rb
class Preflight < Formula
  desc "AI-powered code reviewer CLI"
  homepage "https://github.com/softarn/preflight"
  url "https://github.com/softarn/preflight/releases/download/v0.1.0-alpha.1/preflight-0.1.0a1.tar.gz"
  sha256 "8350255cbbadfb9a4e9275f1eefce9a4227a870af1d3f1975c6dd4ddb316802b"
  license "BSL-1.1"

  depends_on "python@3.9"

  def install
    # Create a virtual environment to install dependencies
    venv = virtualenv_create(libexec, "python3")
    # Install the package into the venv
    system venv/"bin/pip", "install", *std_pip_args, "."
    # Symlink the executable so it's in the user's PATH
    bin.install_symlink libexec/"bin/preflight" => "preflight"
  end

  test do
    # A simple test to ensure the command runs
    system "#{bin}/preflight", "--help"
  end
end
