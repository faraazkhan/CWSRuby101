require 'uri'
require 'net/http'
require 'json'
#require 'open-uri'
class HospitalCompareData
  URL = 'http://data.medicare.gov/resource/ee3i-x2ic.json'
  def analyze
    puts raw_data
    #puts data.read
  end

  protected

  def raw_data
    uri = URI.parse(URL)
    JSON.parse Net::HTTP.get(uri)
    #open uri
  end
end

HospitalCompareData.new.analyze

#Exercise(use google):
#Print only the names of the Hospitals where the "Door to Diagnostic Eval" is under 50
#Sample output:
#Hospital A: 25
#Hospital B: 30
#Now group this analysis by state
#Sample Output
#Alabama has 25 hospitals where DTDE is less than 50
#Now group this analysis by score ranges(1-25, 26-50, 51-75, 76-100) and state 
#Sample Output
#Alabama has 25 hospitals where DTDE is between 1 and 25
#Alabama has 30 hospitals where DTDE is between 26 and 50
#Alabama has 10 hospitals where DTDE is between 51 and 75
#Alabama has 5 hospitals where DTDE is between 76 and 100
