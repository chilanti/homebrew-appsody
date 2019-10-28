class Appsody < Formula
  desc "The Appsody command-line interface"
  homepage "https://www.appsody.dev"
  url "https://github.com/chilanti/appsody/releases/download/0.4.9/appsody-homebrew-0.4.9.tar.gz"
  # version "0.4.9"
  sha256 "6f05dfca4b53bc55d319e8881a6ce9850596adb06914139c9a346c8c8888fa9a"

  def install
    bin.install "appsody"
    bin.install "appsody-controller"
    ohai "Checking prerequisites..."
    retval=check_prereqs
    if retval
      ohai "Done."
    else
      opoo "Docker not detected. Please ensure docker is installed and running before using appsody."
    end
  end

  def check_prereqs
    begin
      original_stderr = $stderr.clone
      original_stdout = $stdout.clone
      $stderr.reopen(File.new("/dev/null", "w"))
      $stdout.reopen(File.new("/dev/null", "w"))
      begin
        system("/usr/local/bin/docker", "ps")
        retval=true
      rescue
        retval=false
      end
    rescue => e
      $stdout.reopen(original_stdout)
      $stderr.reopen(original_stderr)
      raise e
    ensure
      $stdout.reopen(original_stdout)
      $stderr.reopen(original_stderr)
    end
    retval
  end

  test do
    raise "Test not implemented."
  end
end