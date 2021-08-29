class MemoryParser

  attr_reader :filename, :most_page_view, :uniq_most_page_view

  def initialize(filename:)
    raise StandardError, "File does not exists" unless File.exist?(filename)

    @filename = filename
    @most_page_view = {}
    @uniq_most_page_view = {}

    process_file
  end

  def process_file
    File.foreach(@filename) do |line|
      result = line.split(" ")
      next unless result.length == 2

      url, ip = result

      if most_page_view[url].nil?
        most_page_view[url] = 1
      else
        most_page_view[url] += 1
      end

      if uniq_most_page_view[url].nil?
        uniq_most_page_view[url] = { :count => 1, :ips => [ip] }
      elsif !uniq_most_page_view[url][:ips].include?(ip)
        uniq_most_page_view[url][:count] += 1
        uniq_most_page_view[url][:ips] << ip
      end
    end
    
    @most_page_view = most_page_view.sort_by {|key, value| [-value, key]}
    @uniq_most_page_view = uniq_most_page_view.sort_by{|key, value| [-value[:count], key]}
  end

end
