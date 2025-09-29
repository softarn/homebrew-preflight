# Formula: preflight.rb
class Preflight < Formula
  desc "AI-powered code reviewer CLI"
  homepage "https://github.com/softarn/preflight"
  url "https://github.com/softarn/preflight/releases/download/v0.1.0-alpha.3/preflight-0.1.0a4.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "BSL-1.1"

  depends_on "python@3.10"

  def install
    venv_dir = libexec/"venv"
    python_exe = Formula["python@3.10"].opt_bin/"python3.10"

    # Create the virtual environment
    system python_exe, "-m", "venv", venv_dir
    
    # Install build dependencies
    system venv_dir/"bin/pip", "install", "poetry-core"
    
    # Install the package itself
    system "CMAKE_ARGS='-DGGML_METAL=on'", venv_dir/"bin/pip", "install", "."
    
    # Create a wrapper script in the user's PATH
    (bin/"preflight").write_env_script venv_dir/"bin/preflight", PATH: "#{venv_dir}/bin:$PATH"
  end

  test do
    system "#{bin}/preflight", "--help"
  end
end
