# Formula: preflight.rb
class Preflight < Formula
  desc "AI-powered code reviewer CLI"
  homepage "https://github.com/softarn/preflight"
  url "https://github.com/softarn/preflight/releases/download/v0.1.0-alpha.2/preflight-0.1.0a2.tar.gz"
  sha256 "9dbddc2d4d897d5acd3ff80e13b9f30d62b3811c8147d7d0f170a70675241ab7"
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
