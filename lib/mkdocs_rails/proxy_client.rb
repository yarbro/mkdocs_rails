# frozen_string_literal: true

require "net/http"

module MkdocsRails
  class ProxyClient
    class ConnectionError < StandardError; end

    def initialize(port:)
      @port = port
    end

    def get(path)
      uri = URI("http://localhost:#{@port}#{path}")

      Net::HTTP.start(uri.host, uri.port, read_timeout: 5) do |http|
        request = Net::HTTP::Get.new(uri)
        http.request(request)
      end
    rescue Errno::ECONNREFUSED, Errno::ECONNRESET
      raise ConnectionError, "Could not connect to MkDocs server on localhost:#{@port}"
    end
  end
end
