class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  def index
    @events = Event.where('starts_at >= ?', Date.today).where(:published => true)
    if params[:search]
      @events = Event.search(params[:search]).order("created_at DESC")
    end
    # @user_events = current_user.events
  end
  
  def new
		@event = Event.new
		@user = current_user
	end

	def create
		@event = current_user.events.build(event_params)

		if @event.save
			flash[:success] = "Message Sent!"
			redirect_to root_path
		else
			flash[:alert] = "Fail!"
			render :new
		end
	end
	
  def show
    @event = Event.find(params[:id])
  end
  
	private

	def event_params
		params.require(:event).permit(:starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id, :name)
	end
		
end
# class EventsController < ApplicationController
#   before_action :authenticate_user!
#   def index
#     @events = Event.where('starts_at >= ?', Date.today).where(:published => true)
#     if params[:search]
#       @events = Event.search(params[:search]).order("created_at DESC")
#     else
#       @events = Event.where('starts_at >= ?', Date.today).where(:published => true)
#     end
#   end

#   def show
#     @event = Event.find(params[:id])
#   end
  
#   def new
#     @event = current_user.events.build
#     @user = current_user
#   end
  
#   def create
#     @event = current_user.events.build(event_params)
#     if @event.save
#       redirect_to @event
#     else
#       render 'new'
#     end
#   end
  
#   def event_params
#     params.require(:event).permit(:starts_at, :ends_at, :name, :hero_image_url, :extended_html_description)
#   end
# end