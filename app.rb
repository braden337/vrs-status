#require 'sinatra'
require 'net/http'

# begin
#   res = Net::HTTP.get_response(URI::parse('http://205.200.66.50'))
#   puts res.code
# rescue
#   puts "something went wrong"
# end


url = URI::parse("http://205.200.66.50/")

http = Net::HTTP.new(url.host)

http.read_timeout = 2
http.open_timeout = 2
begin
  resp = http.start() do |req|
    req.get(url.path)
  end
  #puts resp.kind_of? Net::HTTPResponse
  puts resp.code
rescue => e
  puts e
end

