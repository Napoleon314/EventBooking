class EventsController < ApplicationController
  def owned
    user = current_user
    if user
      @events = user.events.order(:date)
      render :index
    else
      redirect_to home_path
    end
  end

  def booked
    user = current_user
    if user
      @events = user.booked_events.order(:date)
      render :index
    else
      redirect_to home_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    user = current_user
    if user && user.id == @event.user_id
      render :new
    else
      redirect_to home_path
    end
  end

  def index
    if params[:q]
      @events = Event.where("name LIKE '%" + params[:q] + "%'")
    else
      @events = Event.order(:date)
    end
  end

  def show
    @event = Event.find(params[:id])
    render '/books/index'
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      if @event.capacity != 0 && @event.capacity < @event.books.count
        @event.books.delete_all
      end
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    user = current_user
    if user && user.id == @event.user_id
      @event.destroy
      redirect_to :owned_events
    end
  end

  private
    def event_params
      params.require(:event).permit(:name, :via, :date, :from, :to, :venue, :desc, :contact, :capacity, :price)
    end
end
