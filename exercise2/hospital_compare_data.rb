require 'uri'
require 'net/http'
require 'json'
class HospitalCompareData
  # Generates a simple summary report on Hospital Quality Data
  # Summarizes data for a measure in the following categories:
    # Measure Under 50
    # Measure between 1 and 25
    # Measure between 26 and 50
    # Measure between 51 and 75
    # Measure between 76 and 100
  # By default runs the comparison on Door to Diagnostic Eval and groups the report by state
  # To generate a report with defaults simply call:
    # HospitalCompareData.new.analyze
  # Accepts the following parameters for customization:
    # url => The URL to fetch Hospital Quality Data in JSON format
    # measure => Name of the measure (case insensitive)
    # attr => The attribute in JSON data that holds the measure value
    # group_by => The attribute to group the summary report by
  # Full API with params can be invoked with:
    # HospitalCompareData.new(url, measure, attr, group_by).analyze

  def initialize(url=nil, measure=nil, attr=nil, group_by=nil)
    @url =  url || 'http://data.medicare.gov/resource/ee3i-x2ic.json'
    @measure = measure || 'Door to Diagnostic Eval'
    @measure_attr = attr || 'rate'
    @group_by_attr = group_by || 'state'
  end

  def analyze
    summarize hospitals_with_measure('less than', 50)
    summarize hospitals_with_measure('between',(1..25) )
    summarize hospitals_with_measure('between',(26..50))
    summarize hospitals_with_measure('between',(51..75))
    summarize hospitals_with_measure('between',(76..100))
  end

  private

  def summarize(dataset, group_by_attr=@group_by_attr)
    grouped_data = grouped(dataset, group_by_attr)
    grouped_data.each do |hospital_group|
      print_summary_for hospital_group
    end
  end

  def grouped(data, attr)
    data.group_by {|d| d[attr]}
  end

  def hospitals_with_measure(condition, value_or_range, measure_name=@measure, dataset=raw_data, measure_attr=@measure_attr)
    caption = "Hospitals with #{measure_name} #{condition} #{value_or_range.to_s}"
    puts caption
    dataset.select {|record| has_measure?(record) && meets_condition?(record, condition, measure_attr, value_or_range) }

  end

  def has_measure?(record, measure_name=@measure)
    record['measure'].downcase == measure_name.downcase
  end

  def meets_condition?(record, condition, attr, value_or_range)
    actual_value = record[attr].to_i #assuming we only perform comparisons on integer values
    case condition
    when 'less than'
      actual_value < value_or_range
    when 'between'
      value_or_range.include? actual_value
    end
  end

  def raw_data
    uri = URI.parse(@url)
    json_response = Net::HTTP.get(uri)
    JSON.parse(json_response)
  end


  def print_summary_for(group)
    puts group[0] + ' has ' + group[1].count.to_s + ' qualifying hospitals'
  end
end

HospitalCompareData.new.analyze

