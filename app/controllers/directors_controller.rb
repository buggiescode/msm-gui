class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    name = params.fetch("name")
    dob = params.fetch("dob")
    bio = params.fetch("bio")
    image = params.fetch("image")

    director = Director.new
    director.name = name
    director.dob = dob
    director.bio = bio
    director.image = image

    director.save

    redirect_to("/directors")
  end

  def destroy
    director_id = params.fetch("director_id")

    director_to_delete = Director.where({ :id => director_id }).first

    director_to_delete.destroy

    redirect_to("/directors")
  end

  def update
    director_id = params.fetch("director_id")

    the_director = Director.where({ :id => director_id }).first

    the_director.name = params.fetch("name")
    the_director.dob = params.fetch("dob")
    the_director.bio = params.fetch("bio")
    the_director.image = params.fetch("image")

    the_director.save

    redirect_to("/directors/#{the_director.id}")
  end
end
