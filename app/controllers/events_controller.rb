class EventsController < ApplicationController
  def index
    @events = Event.where('starts_at >= ?', Date.today)
    if params[:search]
      @events = Event.search(params[:search]).order("created_at DESC")
    else
      @events = Event.all.order("created_at DESC")
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end