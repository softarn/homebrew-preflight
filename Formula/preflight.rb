# Formula: preflight.rb
class Preflight < Formula
  desc "AI-powered code reviewer CLI"
  homepage "https://github.com/softarn/preflight"
  url "https://github.com/softarn/preflight/releases/download/v0.1.0-alpha.3/preflight-0.1.0a3.tar.gz"
  sha256 "a63503c17a0f9866bbb16c6d1c5c0908e91d923a749b9e5e785a78b25f2bfe97"
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
