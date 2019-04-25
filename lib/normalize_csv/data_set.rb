require 'csv'

module NormalizeCSV
  class DataSet
    def self.from_csv_string(csv_string)
      csv_rows = CSV.new(csv_string, headers: :first_row)
      rows = csv_rows.map { |row_hash| Row.from_csv_row_hash(row_hash) }
      new(rows)
    end

    attr_reader :rows

    def initialize(rows = [])
      @rows = rows
    end

    def to_csv_string
      CSV.generate(headers: :first_row) do |csv|
        csv << %w(Timestamp Address ZIP FullName FooDuration BarDuration TotalDuration Notes)
        rows.each do |row|
          csv << row.to_csv_row
        end
      end
    end
  end
end