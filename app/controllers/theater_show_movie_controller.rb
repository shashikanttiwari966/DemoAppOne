class TheaterShowMovieController < ApplicationController

  def index
    @trailers = TheaterService.new.trailer_video_clip
  end
end
