class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    title = params.fetch("title")
    year = params.fetch("year").to_i
    duration = params.fetch("duration").to_i
    description = params.fetch("description")
    image = params.fetch("image")
    director_id = params.fetch("director_id").to_i

    movie = Movie.new
    movie.title = title
    movie.year = year
    movie.duration = duration
    movie.description = description
    movie.director_id = director_id
    movie.image = image

    movie.save

    redirect_to("/movies")
  end

  def destroy
    movie_id = params.fetch("movie_id")

    movie_to_delete = Movie.where({ :id => movie_id }).first

    movie_to_delete.destroy

    redirect_to("/movies")
  end

  def update
    movie_id = params.fetch("movie_id")

    the_movie = Movie.where({ :id => movie_id }).first

    the_movie.title = params.fetch("title")
    the_movie.year = params.fetch("year")
    the_movie.duration = params.fetch("duration")
    the_movie.description = params.fetch("description")
    the_movie.image = params.fetch("image")
    the_movie.director_id = params.fetch("director_id")

    the_movie.save

    redirect_to("/movies/#{the_movie.id}")
  end
end
