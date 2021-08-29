class MemoryParser

  attr_reader :filename, :most_page_view, :uniq_most_page_view, :page_journey

  def initialize(filename:)
    raise StandardError, "File does not exists" unless File.exist?(filename)

    @filename = filename
    @most_page_view = {}
    @uniq_most_page_view = {}
    @page_journey = {}

    process_file
  end

  def process_file
    File.foreach(@filename) do |line|
      result = line.split(" ")
      next unless result.length == 2

      url, ip = result

      process_most_page_view(url)
      process_uniq_most_page_view(url, ip)
      process_page_journey(url, ip)
    end

    @most_page_view = most_page_view.sort_by {|key, value| [-value, key]}
    @uniq_most_page_view = uniq_most_page_view.sort_by{|key, value| [-value[:count], key]}
  end

  def process_most_page_view(url)
    if most_page_view[url].nil?
      most_page_view[url] = 1
    else
      most_page_view[url] += 1
    end
  end

  def process_uniq_most_page_view(url, ip)
    if uniq_most_page_view[url].nil?
      uniq_most_page_view[url] = { :count => 1, :ips => [ip] }
    elsif !uniq_most_page_view[url][:ips].include?(ip)
      uniq_most_page_view[url][:count] += 1
      uniq_most_page_view[url][:ips] << ip
    end
  end

  def process_page_journey(url, ip)
    if page_journey[ip].nil?
      page_journey[ip] = [url]
    else
      page_journey[ip] << url
    end
  end

end
