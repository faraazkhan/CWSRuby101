
# Read files and command line arguments
old_facilities = File.open(ARGV[0] || 'old_facilities.txt').readlines
new_facilities = File.open(ARGV[1] || 'new_facilities.txt').readlines
search_string = ARGV[2] || ''

# Filter file content if search criteria is provided
if search_string && search_string != ''
  search_string = search_string.downcase # filtering does not have to be case sensitive
  old_facilities = old_facilities.select do |f|
    f.downcase.index search_string
  end
  new_facilities = new_facilities.select do |f|
    f.downcase.index search_string
  end
end

# Identify changes in files
added_facilities = new_facilities - old_facilities
removed_facilities = old_facilities - new_facilities



# Generate formatted report
total_length = 0
added_facilities.each do |facility|
  length = facility.length
  total_length = length + total_length
end

puts "The following #{added_facilities.count} #{search_string} facilities were added with a total of #{total_length} characters:"

added_facilities.each do |facility|
  length = facility.length
  puts "#{facility}(#{length})"
end


total_length = 0

removed_facilities.each do |facility|
  length = facility.length
  total_length = length + total_length
end


puts "The following #{removed_facilities.count} #{search_string} facilities were removed a total of #{total_length} characters:"
puts removed_facilities
removed_facilities.each do |facility|
  length = facility.length
  puts "#{facility}(#{length})"
end
