class GenresController < ApplicationController
  before_action :require_signin
  before_action :require_admin
  before_action :set_genre, except: [:index, :new, :create]

  def index
    @genres = Genre.all.order(name: :desc)
  end

  def new
    if request.referrer && request.referrer.include?("/movies/")
        session[:intended_url] = request.referrer
    end
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.new(genre_params)
    redirect_url = session[:intended_url] || genres_path
    if @genre.save
      redirect_to redirect_url, notice: "Genre created successfully"
      session[:intended_url] = nil
    else
      render :new, notice: "Something went wrong, please try again"
    end
  end
  
  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, notice: "Genre updated successfully"
    else
      render :edit, alert: "Something went wrong, try again"
    end
  end
  
  def destroy
    @genre.destroy 
    redirect_to genres_path, alert: "Genre deleted successfully"
  end

  private 

    def set_genre
      @genre = Genre.find_by(slug: params[:id])
    end

    def genre_params
      params.require(:genre).permit(:name)
    end
  
end
