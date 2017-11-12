class VenuesIframesController < ApplicationController
  def index
  	@venues = Venue.all
  end

  def show
  end
end
