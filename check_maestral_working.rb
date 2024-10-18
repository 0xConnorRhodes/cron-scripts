output = `maestral status`

if output == "Maestral daemon is not running.\n"
  puts "Maestral daemon is not running."
  exit(1)
end

output = output.split("\n")
output = output.reject { |line| line.empty? }
output = output.reject { |line| line.match?(/^Account/) }
output = output.reject { |line| line.match?(/^Usage/) }

error_line = output[1]
error_count = error_line.match(/Sync errors\s+(\d+)/)[1].to_i

if error_count > 0
  puts "Sync Errors"
  exit(1)
end

status_line = output[0].rstrip
status = status_line.split(' ', 2)[1]

if status == "Paused"
  puts "Paused"
  exit(1)
end

if status == "Up to date"
  puts "Up to date"
  `curl -s https://hc-ping.com/4923c31a-6605-4612-9758-30d546a82100`
  exit(0)
end

puts "case not caught"
exit(1)
