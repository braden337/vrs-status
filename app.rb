require 'sinatra'
require 'sinatra/json'
require 'net/http'

set :bind, '0.0.0.0'


bases = { :le => { name: "Shop", url: "http://205.200.8.215/", status: nil },
               :nh => {name: "Argyle", url: "http://199.19.61.54:90/", status: nil},
               :bo => { name: "McGillivray", url: "http://66.244.213.166/", status: nil },
               :ki => { name: "La Salle", url: "http://66.244.214.60/", status: nil },
               :ta => { name: "Roblin", url: "http://206.45.135.119:81/", status: nil },
               :br => { name: "Petersfield", url: "http://206.45.204.94/", status: nil },
               :in => { name: "Interlake", url: "http://199.19.62.91/", status: nil },
               :lo => { name: "Riverton", url: "http://104.153.49.53:81/", status: nil },
               :py => { name: "Fisher Branch", url: "http://104.218.46.149:81/", status: nil } }
               

def checkStatus(base)
    # # outArr = []
    # bases.each do |base|
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
          base[:status] = "online" #if resp.code.to_i == 401
        rescue => e
          #puts e
          base[:status] = "offline"
        end #close begin
        base
    # end #close bases.each
end

get '/' do
  @bases = bases
  erb :index
end

get '/:base' do |b|
  json checkStatus(bases[b.to_sym])
end


#SocketError, EOFError, NameError, Errno::ECONNRESET, Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ETIMEDOUT






















