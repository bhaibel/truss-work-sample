require 'spec_helper'

RSpec.describe NormalizeCSV do
  describe "UTF-8 normalization" do
    it "makes no changes to valid UTF-8" do
      input_csv_string = <<~EOT
        Timestamp,Address,ZIP,FullName,FooDuration,BarDuration,TotalDuration,Notes
      EOT

      result = NormalizeCSV.normalize(input_csv_string)

      expect(result).to eq(input_csv_string)
    end

    it "replaces invalid UTF-8 codepoints with the UTF replacement character" do

      input_csv_string = <<~EOT
        Timestamp,Address,ZIP,FullName,FooDuration,BarDuration,TotalDuration,Notes
        10/5/12 10:31:11 PM,"Test Pattern Town, Test Pattern, TP",121,hi \255,1:23:32.123,1:32:33.123,zzsasdfa,1:11:11.123
      EOT

      result = NormalizeCSV.normalize(input_csv_string)

      expect(result).to eq <<~EOT
        Timestamp,Address,ZIP,FullName,FooDuration,BarDuration,TotalDuration,Notes
        2012-10-06T01:31:11-05:00,"Test Pattern Town, Test Pattern, TP",121,HI �,5012.123,5553.123,10565.246,1:11:11.123
      EOT
    end
  end
end