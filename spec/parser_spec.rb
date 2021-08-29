require_relative '../parser'

RSpec.describe 'Parser' do

  describe "#initalize" do
    it "should success" do
      parser = Parser.new(filename: "./spec/fixtures/test_webserver.log")
      expect(parser.filename).to eq "./spec/fixtures/test_webserver.log"
    end

    it "should raise error if file not exists" do
      expect {Parser.new(filename: "file_not_exists")}.to raise_error("File does not exists")
    end
  end

end
