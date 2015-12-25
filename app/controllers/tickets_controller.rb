class TicketsController < ApplicationController
  def new 
    @event = Event.find(params[:event_id])
  end
 
  # def create
  #   @event = Event.find(params[:event_id])
  #   @ticket = @event.ticket_types.create(params[:ticket_type].permit(:name, :price, :max_quantity))
  #   redirect_to event_path(@event)
  # end
end
