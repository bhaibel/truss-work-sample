require 'spec_helper'

require 'bigdecimal'

module NormalizeCSV
  RSpec.describe DataSet do
    it "can be built from a CSV string", focus: true do
      input_csv_string = <<~EOT
        Timestamp,Address,ZIP,FullName,FooDuration,BarDuration,TotalDuration,Notes
        4/1/11 11:00:00 AM,"123 4th St, Anywhere, AA",94121,Monkey Alberto,1:23:32.123,1:32:33.123,zzsasdfa,I am the very model of a modern major general
      EOT

      data_set = DataSet.from_csv_string(input_csv_string)

      aggregate_failures do
        expect(data_set.rows.first.timestamp_as_pst).to eq(DateTime.strptime("4/1/11 11:00:00 AM -8:00", "%m/%d/%y %l:%M:%S %p %z"))
        expect(data_set.rows.first.address).to eq("123 4th St, Anywhere, AA")
        expect(data_set.rows.first.zip).to eq("94121")
        expect(data_set.rows.first.full_name).to eq("Monkey Alberto")
        expect(data_set.rows.first.foo_duration).to eq(BigDecimal.new(5012.123, 12))
        expect(data_set.rows.first.bar_duration).to eq(BigDecimal.new(5553.123, 12))
        expect(data_set.rows.first.notes).to eq("I am the very model of a modern major general")
      end
    end

    it "can be converted to a CSV string" do
      input_csv_string = <<~EOT
        Timestamp,Address,ZIP,FullName,FooDuration,BarDuration,TotalDuration,Notes
        4/1/11 11:00:00 AM,"123 4th St, Anywhere, AA",94121,Monkey Alberto,1:23:32.123,1:32:33.123,zzsasdfa,I am the very model of a modern major general
      EOT

      data_set = DataSet.from_csv_string(input_csv_string)

      expect(data_set.to_csv_string).to eq <<~EOT
        Timestamp,Address,ZIP,FullName,FooDuration,BarDuration,TotalDuration,Notes
        2011-04-01T14:00:00-05:00,"123 4th St, Anywhere, AA",94121,MONKEY ALBERTO,5012.123,5553.123,10565.246,I am the very model of a modern major general
      EOT
    end

  end
end