class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    name = params.fetch("name")
    dob = params.fetch("dob")
    bio = params.fetch("bio")
    image = params.fetch("image")

    actor = Actor.new
    actor.name = name
    actor.dob = dob
    actor.bio = bio
    actor.image = image

    actor.save

    redirect_to("/actors")
  end

  def destroy
    actor_id = params.fetch("actor_id")

    actor_to_delete = Actor.where({ :id => actor_id }).first

    actor_to_delete.destroy

    redirect_to("/actors")
  end

  def update
    actor_id = params.fetch("actor_id")

    the_actor = Actor.where({ :id => actor_id }).first

    the_actor.name = params.fetch("name")
    the_actor.dob = params.fetch("dob")
    the_actor.bio = params.fetch("bio")
    the_actor.image = params.fetch("image")

    the_actor.save

    redirect_to("/actors/#{the_actor.id}")
  end
end
