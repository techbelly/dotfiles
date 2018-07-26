#!/usr/bin/env ruby

args = ARGV

def run_on_vagrant(cmd)
  c = "cd /trainline/pacon2 && \
       source ../development_env/test_env && \
       #{cmd}"
  cmd = "ssh trainline -t \"bash -l -c '#{c}'\""
  system(cmd)
end

case args.length
when 0
  run_on_vagrant('make test')
when 1
  run_on_vagrant("bundle exec m #{args[0]}")
when 2
  run_on_vagrant("bundle exec m #{args[0]} -l #{args[1]}")
end
