module FavoritesHelper
  def favorite_or_unfavorite_button(favorite, movie)
    if favorite
        button_to "♥️", movie_favorite_path(movie, favorite), method: :delete
    else
        button_to "♡", movie_favorites_path(movie)
    end
  end
end
