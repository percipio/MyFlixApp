class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    before_action :set_movie, only: [:show, :edit, :update, :destroy]

    def index
        case params[:filter]
        when "recent"
            @movies = Movie.recent
        when "upcoming"
            @movies = Movie.upcoming
        when "flops"
            @movies = Movie.flops
        when "hits"
            @movies = Movie.hits
        else
            @movies = Movie.released
        end
    end

    def new
        @movie = Movie.new
    end

    def show
        @fans = @movie.fans
        @genres = @movie.genres
        @favorite = current_user.favorites.find_by(movie_id: @movie.id) if current_user
    end

    def edit
    end

    def update
        if @movie.update(movie_params)
            redirect_to @movie, notice: "Event successfully updated!"
        else
            render :edit
        end
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie, notice: "Event successfully created!"
        else
            render :new
        end
    end

    def destroy
        @movie.destroy
        redirect_to movies_path, alert: "Movie successfully deleted!"
    end
    
    private

        def movie_params
            params.require(:movie)
                .permit(:title, :description, :director, :duration, :image_file_name, :rating, :released_on, :total_gross, genre_ids: [])
        end

        def set_movie
            @movie = Movie.find_by(slug: params[:id])
        end
        
    
end
