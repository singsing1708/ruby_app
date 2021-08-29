require_relative "./lib/memory_parser"


if ARGV.length != 1
  puts "Incorrect argument"
  puts "The correct syntax should be 'ruby parser.rb webserver.log'"
  exit
end

memory_parser = MemoryParser.new(filename: ARGV[0])

memory_parser.most_page_view.each do |result|
  p "#{result[0]} #{result[1]} unique views"
end

p "*"*88

memory_parser.uniq_most_page_view.each do |result|
  p "#{result[0]} #{result[1][:count]} unique views"
end
