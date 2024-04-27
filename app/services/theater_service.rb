require 'uri'
require 'net/http'
require 'openssl'
class TheaterService < ApplicationService
  attr_accessor :title

  def initialize(title = nil)
    @title = title
  end

  def trailer_video_clip
    @url = site_url("get-videos?tconst=tt0944947&limit=30&region=us")
    get_response
  end

  def get_overview_details
    @url = site_url("get-overview-details?tconst=#{@title}&currentCountry=US")
    get_response
  end

  def get_most_popular_movies
    @url = site_url("get-most-popular-movies?homeCountry=US&purchaseCountry=US&currentCountry=US")
    get_response
  end

  private

  def site_url(link)   
    URI("https://imdb8.p.rapidapi.com/title/#{link}")
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
    request["X-RapidAPI-Key"] = 'e93ae72393msh637f4bbd575c474p1f5441jsna150fbe8d413'
    request["X-RapidAPI-Host"] = 'imdb8.p.rapidapi.com'
    request
  end
end