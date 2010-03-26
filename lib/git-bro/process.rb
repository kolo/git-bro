require 'windows/process'
require 'windows/handle'

module Process
  VERSION = '0.0.1'

  extend Windows::Process
  extend Windows::Handle

  def self.create(cmdline, opts = {:close_handles => true})
    startinfo = Array.new(18,0).pack("LLLLLLLLLLLLSSLLLL")
    startinfo[0,4] = [startinfo.size].pack("L")

    pi = Array.new(4,0).pack("LLLL")

    res = CreateProcess(0, cmdline, 0, 0, FALSE, 0, 0, 0, startinfo, pi)

    unless res
      puts 'Start process failed!'
      return
    end

    if opts[:close_handles]
      CloseHandle(pi[0,4].unpack("L").first)
      CloseHandle(pi[4,4].unpack("L").first)
    end
  end
end
