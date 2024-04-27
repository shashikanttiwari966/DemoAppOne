require 'uri'
require 'net/http'
require 'openssl'
class MoviegluService < ApplicationService
  attr_accessor :title

  def initialize(title = nil)
    @title = title
  end

  def trailer(film_id)
    debugger
    @url = site_url("https://api-gate2.movieglu.com/trailers/?film_id=#{film_id}")
    get_response
  end

  def coming_soon
    @url = site_url("https://api-gate2.movieglu.com/filmsComingSoon/?n=10")
    get_response
  end

  def films_now_showing
    @url = site_url("https://api-gate2.movieglu.com/filmsNowShowing/?n=2")
    get_response
  end

  private

  def site_url(link)   
    URI(link)
  end

  def get_response
    http = Net::HTTP.new(@url.host, @url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(request_headers)
    JSON.parse(response.read_body)  
  end

  def request_headers
    request = Net::HTTP::Get.new(@url)
    request["x-api-key"] = 'vyYj4pAOMk1u5iimkthGBa8olwuhhTA9T5WJEwt1'
    request["client"] = 'DEVE_31'
    request["authorization"] = 'Basic REVWRV8zMTo2VjVaWTVuZEZZcjU='
    request["territory"] = 'IN'
    request["api-version"] = 'v200'
    request["geolocation"] = '22.719568, 75.857727'
    request["device-datetime"] = '2023-05-24T10:51:10.009Z'
    request["X-Amz-Date"] = '2023-05-24T10:51:10.009Z'
    request
  end
end