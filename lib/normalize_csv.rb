require 'normalize_csv/data_set'
require 'normalize_csv/row'

module NormalizeCSV
  def self.normalize(input_csv_string)
    DataSet
      .from_csv_string(input_csv_string)
      .to_csv_string
  end
end