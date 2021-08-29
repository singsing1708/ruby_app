class Parser
  attr_reader :filename

  def initialize(filename:)
    raise StandardError, "File does not exists" unless File.exist?(filename)

    @filename = filename
  end
end
