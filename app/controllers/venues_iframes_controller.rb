class VenuesIframesController < ApplicationController
  def index
    @search = Venue.search(params[:q])
    @venues = @search.result
  end

  def show
  end
end
