class EventsController < ApplicationController
  include EventsHelper
  before_action :authenticate_user!, only: [:new , :show]
  before_action :not_validated_yet, only: [:show]


  def show
  	@event = Event.find(params["id"])
    gon.event = @event
    gon.owner = @event.owner
    gon.sport = @event.sport
    gon.user = current_user
    gon.attendance = current_user.attendances.where(event_id: @event.id).exists? && @event.owner_id != current_user.id
    @comment = @event.comments
  end

  def index
   @events = Event.search(params)
   @events_hash = @events.group_by_day { |evt| evt.start_date }
   @months_array_fr = [ nil, "Janvier", "Fevrier" ," Mars" , "Avril" , "Mai" , "Juin" ,"Juillet", "Août" , "Septembre" , "Octobre" , "Novembre" ,"Décembre"]
   @days_array_fr = ["Dimanche" , "Lundi "," Mardi" , "Mercredi" ,"Jeudi" , "Vendredi", "Samedi" ]
 end

  def create
    puts "paramsr***********"
    date = (params[:start_date] + " " + params[:hour_start]).in_time_zone
    puts date
    @event = Event.new(title: params[:title], description: params[:description], start_date: date, duration: params[:duration], sport_id: params[:sport_id], city_id: params[:city_id], owner_id: current_user.id)
    @event.latitude =  params[:latitude]
    @event.longitude =  params[:longitude]
    if @event.save
      redirect_to event_path(@event.id)
    else
      render :new
    end
  end

  private



end
