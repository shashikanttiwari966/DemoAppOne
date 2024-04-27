class MoviegluController < ApplicationController

  def index
    # @trailer = MoviegluService.new.trailer(film_id)
    @coming_soon = MoviegluService.new.coming_soon()
    @films_now_showing = MoviegluService.new.films_now_showing()
    # render json: @trailer
  end
end
