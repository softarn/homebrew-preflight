# Formula: preflight.rb
class Preflight < Formula
  desc "AI-powered code reviewer CLI"
  homepage "https://github.com/softarn/preflight"
  url "https://github.com/softarn/preflight/releases/download/v0.1.0-alpha.1/preflight-0.1.0a1.tar.gz"
  sha256 "8350255cbbadfb9a4e9275f1eefce9a4227a870af1d3f1975c6dd4ddb316802b"
  license "BSL-1.1"

  depends_on "python@3.9"

  def install
    venv_dir = libexec/"venv"
    python_exe = Formula["python@3.9"].opt_bin/"python3.9"

    # Create the virtual environment
    system python_exe, "-m", "venv", venv_dir
    
    # Install build dependencies
    system venv_dir/"bin/pip", "install", "poetry-core"
    
    # Install the package itself
    system venv_dir/"bin/pip", "install", "."
    
    # Create a wrapper script in the user's PATH
    (bin/"preflight").write_env_script venv_dir/"bin/preflight", PATH: "#{venv_dir}/bin:$PATH"
  end

  test do
    system "#{bin}/preflight", "--help"
  end
end
