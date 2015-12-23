class EventsController < ApplicationController
  def index
    @events = Event.where('starts_at >= ?', Date.today).where(:published => true)
    if params[:search]
      @events = Event.search(params[:search]).order("created_at DESC")
    else
      @events = Event.all.order("created_at DESC")
    end
  end

  def show
    @event = Event.where(:published => true).find(params[:id])
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.create(event_params)
  end
  
  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :name, :hero_image_url, :extended_html_description)
  end
end