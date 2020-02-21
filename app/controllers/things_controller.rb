class ThingsController < ApplicationController
  def index
    @things = Thing.all.order({ :created_at => :desc })

    render({ :template => "things/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @thing = Thing.where({:id => the_id }).at(0)

    render({ :template => "things/show.html.erb" })
  end

  def create
    @thing = Thing.new
    @thing.user_id = params.fetch("query_user_id")

    if @thing.valid?
      @thing.save
      redirect_to("/things", { :notice => "Thing created successfully." })
    else
      redirect_to("/things", { :notice => "Thing failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @thing = Thing.where({ :id => the_id }).at(0)

    @thing.user_id = params.fetch("query_user_id")

    if @thing.valid?
      @thing.save
      redirect_to("/things/#{@thing.id}", { :notice => "Thing updated successfully."} )
    else
      redirect_to("/things/#{@thing.id}", { :alert => "Thing failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @thing = Thing.where({ :id => the_id }).at(0)

    @thing.destroy

    redirect_to("/things", { :notice => "Thing deleted successfully."} )
  end
end
