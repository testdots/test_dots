require 'openssl'

module TestDots
  class Api
    def post(payload)
      http = Net::HTTP.new(TestDots.configuration.host, TestDots.configuration.port)
      if TestDots.configuration.use_ssl
        http.use_ssl = true
        http.ca_file = TestDots.configuration.cacert_path
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      else
        http.use_ssl = false
      end
      request = Net::HTTP::Post.new(TestDots.configuration.endpoint, 'Content-Type' => 'application/json')
      request.basic_auth(TestDots.configuration.api_key, "")
      request.body = payload
      http.request(request)
    end
  end
end
