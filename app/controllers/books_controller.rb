class BooksController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end

  def create
    user = current_user
    unless user
      flash.now[:error] = "Please sign in with a user to book the event."
      render :index
      return
    end
    @event = Event.find(params[:event_id])
    unless @event.capacity == 0 || @event.capacity > @event.books.count
      flash.now[:error] = "The event has been booked out."
      render :index
      return
    end
    @book = @event.books.build
    @book.user_id = user.id
    unless @book.save
      flash.now[:error] = "Unknown error while booking the event."
      render :index
      return
    end
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:event_id])
    @book = Book.find(params[:id])
    user = current_user
    if user && user.id == @book.user_id && @event.id == @book.event_id
      @book.destroy
    end
    redirect_to @event
  end
end
