require 'net/http'

begin
  Net::HTTP.get_response(URI::parse("http://64.141.35.142"))
  puts "success"
rescue
  puts "something went wrong"
end
