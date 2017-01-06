shared_context 'forked spec' do
  around do |example|
    read, write = IO.pipe
    pid = fork do
      $stdout.sync = true
      $stderr.sync = true
      res = example.run
      Marshal.dump(res, write)
      write.close
    end
    Process.waitpid2 pid
    res = Marshal.load(read)
    example.example.send :set_exception, res if res && res.to_s != ''
    example.instance_variable_set('@executed', true)
    read.close
  end
end
