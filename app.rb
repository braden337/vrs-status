require 'sinatra'
require 'sinatra/json'
require 'net/http'

set :bind, '0.0.0.0'


bases_hash = { :shop => { name: "Shop", url: "http://205.200.66.50/", status: nil },
            :bossuyt => { name: "McGillivray", url: "http://66.244.213.166/", status: nil },
           :kirchner => { name: "La Salle", url: "http://64.141.35.142/", status: nil },
           :tailleau => { name: "Roblin", url: "http://206.45.135.119:81/", status: nil },
            :bracken => { name: "Petersfield", url: "http://206.45.204.94/", status: nil },
          :interlake => { name: "Interlake", url: "http://199.19.62.91/", status: nil },
             :loewen => { name: "Riverton", url: "http://104.153.49.53:81/", status: nil },
             :pyziak => { name: "Fisher Branch", url: "http://104.218.46.149:81/", status: nil } }


bases = [
            {name: "Shop", url: "http://205.200.66.50/", status: nil},
            {name: "McGillivray", url: "http://66.244.213.166/", status: nil},
            {name: "La Salle", url: "http://64.141.35.142/", status: nil},
            {name: "Roblin", url: "http://206.45.135.119:81/", status: nil},
            {name: "Petersfield", url: "http://206.45.204.94/", status: nil},
            {name: "Interlake", url: "http://199.19.62.91/", status: nil},
            {name: "Riverton", url: "http://104.153.49.53:81/", status: nil},
            {name: "Fisher Branch", url: "http://104.218.46.149:81/", status: nil},
           ]

def checkStatus(bases)
    # outArr = []
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
          base[:status] = "success" #if resp.code.to_i == 401
        rescue => e
          #puts e
          base[:status] = "danger"
        end #close begin
    end #close bases.each
end

get '/' do
  @bases = bases
  erb :index
end

get '/:base' do |b|
  json bases_hash[b.to_sym]
end


#SocketError, EOFError, NameError, Errno::ECONNRESET, Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ETIMEDOUT






















