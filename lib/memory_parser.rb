class MemoryParser

  attr_reader :filename, :most_page_view, :uniq_most_page_view, :page_journey, :page_view

  def initialize(filename:)
    raise StandardError, "File does not exists" unless File.exist?(filename)

    @filename = filename
    @page_journey = {}
    @page_view = {}

    @most_page_view = {}
    @uniq_most_page_view = {}

    process_file
  end

  private

  def process_file
    File.foreach(@filename) do |line|
      result = line.split(" ")
      next unless result.length == 2

      url, ip = result

      process_page_view(url, ip)
      process_page_journey(url, ip)
    end

    clean_up_data
  end

  def clean_up_data
    @most_page_view = page_view.sort_by {|key, value| [-value[:count], key]}
    @uniq_most_page_view = page_view.sort_by{|key, value| [-value[:uniq_count], key]}
    @page_view.clear
  end

  def process_page_view(url, ip)
    if page_view[url].nil?
      page_view[url] = { :count => 1, :ips => [ip], :uniq_count => 1 }
    elsif page_view[url][:ips].include?(ip)
      page_view[url][:count] += 1
    else
      page_view[url][:uniq_count] += 1
      page_view[url][:count] += 1
      page_view[url][:ips] << ip
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
