require_relative "../lib/inline_parser"

RSpec.describe 'InlineParser' do

  before(:all) do
   @inline_parser = InlineParser.new(filename: "./spec/fixtures/test_webserver.log")
  end

  describe "#initalize" do
    it "should success" do
      expect(@inline_parser.filename).to eq "./spec/fixtures/test_webserver.log"
    end

    it "should raise error if file not exists" do
      expect {InlineParser.new(filename: "file_not_exists")}.to raise_error("File does not exists")
    end
  end

  describe "#most_page_view" do
    it "should return the desc order of page view" do
      result = @inline_parser.most_page_view

      expect(result[0][0]).to eq "/help_page/1"
      expect(result[0][1][:count]).to eq 6
      expect(result[1][0]).to eq "/contact"
      expect(result[1][1][:count]).to eq 3
      expect(result[2][0]).to eq "/about/2"
      expect(result[2][1][:count]).to eq 1
    end
  end

  describe "#uniq_most_page_view" do
    it "should return the desc order of uniq page view" do
      result = @inline_parser.uniq_most_page_view

      expect(result[0][0]).to eq "/help_page/1"
      expect(result[0][1][:uniq_count]).to eq 5
      expect(result[1][0]).to eq "/contact"
      expect(result[1][1][:uniq_count]).to eq 2
      expect(result[2][0]).to eq "/about/2"
      expect(result[2][1][:uniq_count]).to eq 1
    end
  end

  describe "#page_journey" do
    it "should return the page journey for the same ip" do
      inline_parser = InlineParser.new(filename: "./spec/fixtures/test_page_journey_webserver.log")
      result = inline_parser.page_journey

      expect(result["929.398.951.881"]).to eq ["/help_page/1", "/help_page/2", "/help_page/3"]
      expect(result["929.398.951.889"]).to eq ["/help_page/1"]
      expect(result["444.701.448.104"]).to eq ["/index", "/about"]
      expect(result["061.945.150.735"]).to eq ["/about"]
    end
  end

end
