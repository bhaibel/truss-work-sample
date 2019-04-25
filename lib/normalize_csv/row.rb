require 'bigdecimal'

module NormalizeCSV
  class Row
    def self.from_csv_row_hash(hash)
      result = new
      result.timestamp_as_pst = pst_datetime_from_unmarked_string(hash['Timestamp'])
      result.address = hash['Address']
      result.zip = hash['ZIP'].to_s
      result.full_name = hash["FullName"]
      result.foo_duration = duration_to_seconds(hash['FooDuration'])
      result.bar_duration = duration_to_seconds(hash['BarDuration'])
      result.notes = hash['Notes']
      result
    end

    def self.pst_datetime_from_unmarked_string(string)
      DateTime.strptime("#{string} -8:00", "%m/%d/%y %l:%M:%S %p %z")
    end

    def self.duration_to_seconds(duration)
      hours, minutes, seconds = duration.split(":").map { |segment| BigDecimal.new(segment) }
      (hours * 60 * 60) + (minutes * 60) + seconds
    end

    attr_accessor(
      :timestamp_as_pst,
      :address,
      :zip,
      :full_name,
      :foo_duration,
      :bar_duration,
      :notes
    )

    def timestamp_as_est
      timestamp_as_pst.new_offset("-5:00").iso8601
    end

    def total_duration
      foo_duration + bar_duration
    end

    def to_csv_row
      csv_row = CSV::Row.new([], [])
      csv_row['Timestamp'] = timestamp_as_est
      csv_row['Address'] = address
      csv_row['ZIP'] = zip
      csv_row['FullName'] = full_name.upcase
      csv_row['FooDuration'] = foo_duration.to_f
      csv_row['BarDuration'] = bar_duration.to_f
      csv_row['TotalDuration'] = total_duration.to_f
      csv_row['Notes'] = notes
      csv_row
    end
  end
end