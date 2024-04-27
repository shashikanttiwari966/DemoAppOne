module TheaterShowMovieHelper

  def show(rating)
    data = ""
    (0..9).each do |i|
      if i <= rating.to_i
        data  = data + "<i class='fa fa-star rating-color'></i>"
      else
        data  = data + "<i class='fa fa-star'></i>"
      end
    end
    data
  end
end
