class WelcomeController < ActionController::Base
  require 'net/http'
  require 'uri'

  def index
  end

  def oauth
      code = params[:code]

      client_id = 'YOUR_CLIENT_ID'
      client_secret = 'YOUR__CLIENT_SECRET'
      redirect_uri = 'YOUR_REDIRECT_URI'

      uri = URI.parse('https://api-ssl.bitly.com/oauth/access_token')
      begin
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({'client_id' => client_id, 'client_secret' => client_secret, 'redirect_uri' => redirect_uri, 'code' => code})

        response = https.request(request)
        puts "#{response.code} -- #{response.body}" #sanity check

        @data = {}
        response.body.split('&').each do |pair|
          a = pair.split('=')
          @data[a[0].to_sym] = a[1]
        end
      rescue
      end
  end
end
