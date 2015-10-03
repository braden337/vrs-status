require 'sinatra'
require 'net/http'

basesarr = [
            {name: "Shop", url: "http://205.200.66.50/"},
            {name: "Interlake", url: "http://199.19.62.91/"},
            {name: "Bracken", url: "http://206.45.204.94/"},
            {name: "Loewen", url: "http://104.153.49.53:81/"},
            {name: "Pyziak", url: "http://104.218.46.149:81/"},
            {name: "Tailleau", url: "http://206.45.135.119:81/"},
            {name: "Bossuyt", url: "http://66.244.213.166/"},
            {name: "Kirchner", url: "http://64.141.35.142/"},
           ]

def checkStatus(bases)
    outArr = []
    bases.each do |base|
        # found lots of info at
        # http://opensourceconnections.com/blog/2008/04/24/adding-timeout-to-nethttp-get_response/
        url = URI::parse(base[:url])
        http = Net::HTTP.new(url.host, url.port)
        http.read_timeout = 2
        http.open_timeout = 2
        begin
          resp = http.start() do |req|
            req.get(url.path)
          end
          #puts resp.kind_of? Net::HTTPResponse
          #puts resp.code
          outArr << {name: base[:name], url: base[:url], status: "success"} #if resp.code.to_i == 401
        rescue => e
          #puts e
          outArr << {name: base[:name], url: base[:url], status: "danger"}
        end #close begin
    end #close bases.each
    outArr
end

get '/' do
  @bases = checkStatus(basesarr)
  erb :index
end

#SocketError, EOFError, NameError, Errno::ECONNRESET, Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ETIMEDOUT