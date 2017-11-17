require_relative 'text_interface'
require 'socket'

server = TCPServer.open(8000)
loop do
  Thread.start(server.accept) do |client|
    line = client.gets("\0")
    probability = TextInterface.probability_for(line)
    client.print probability.to_s + "\0"
    client.close
  end
end
