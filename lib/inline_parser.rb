class InlineParser

  attr_reader :filename, :page_view, :page_journey_data

  def initialize(filename:)
    raise StandardError, "File does not exists" unless File.exist?(filename)

    @filename = filename
    @page_journey_data = {}
    @page_view = {}
  end

  def most_page_view
    process_page_view

    result = page_view.sort_by {|key, value| [-value[:count], key]}
    page_view.clear

    result
  end

  def uniq_most_page_view
    process_page_view

    result = page_view.sort_by{|key, value| [-value[:uniq_count], key]}
    page_view.clear

    result
  end

  def page_journey
    process_page_journey

    page_journey_data
  end

  private

  def process_file
    File.foreach(@filename) do |line|
      result = line.split(" ")
      next unless result.length == 2

      yield(result[0], result[1])
    end

  end

  def process_page_view
    process_file do |url, ip|
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
  end

  def process_page_journey
    process_file do |url, ip|
      if page_journey_data[ip].nil?
        page_journey_data[ip] = [url]
      else
        page_journey_data[ip] << url
      end
    end
  end

end
