require_relative "../lib/memory_parser"

RSpec.describe 'MemoryParser' do

  describe "#initalize" do
    it "should success" do
      memory_parser = MemoryParser.new(filename: "./spec/fixtures/test_webserver.log")
      expect(memory_parser.filename).to eq "./spec/fixtures/test_webserver.log"
    end

    it "should raise error if file not exists" do
      expect {MemoryParser.new(filename: "file_not_exists")}.to raise_error("File does not exists")
    end
  end

  describe "#most_page_view" do
    it "should return the desc order of page view" do
      memory_parser = MemoryParser.new(filename: "./spec/fixtures/test_webserver.log")
      result = memory_parser.most_page_view
      expect(result[0]).to eq ["/help_page/1", 6]
      expect(result[1]).to eq ["/contact", 3]
      expect(result[2]).to eq ["/about/2", 1]
    end
  end

  describe "#uniq_most_page_view" do
    it "should return the desc order of uniq page view" do
      memory_parser = MemoryParser.new(filename: "./spec/fixtures/test_webserver.log")
      result = memory_parser.uniq_most_page_view
      expect(result[0][0]).to eq "/help_page/1"
      expect(result[0][1][:count]).to eq 5
      expect(result[1][0]).to eq "/contact"
      expect(result[1][1][:count]).to eq 2
      expect(result[2][0]).to eq "/about/2"
      expect(result[2][1][:count]).to eq 1
    end
  end

end
