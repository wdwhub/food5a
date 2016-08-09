class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  def index
    @venues = Venue.all
  end

  # GET /venues/1
  def show
    @venue    = Venue.find(params[:id])
    @photos   = @venue.foursquare_eatery.find_cached_images
    @tips     = @venue.foursquare_eatery.find_cached_tips
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      redirect_to @venue, notice: 'Venue was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      redirect_to @venue, notice: 'Venue was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
    redirect_to venues_url, notice: 'Venue was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def venue_params
      params.require(:venue).permit(:name, :permalink, :category_code, :portion_size, :cost_code, :cuisine, :phone_number, :entree_range, :when_to_go, :parking, :bar, :wine_list, :dress, :awards, :breakfast_hours, :lunch_hours, :dinner_hours, :house_specialties, :counter_quality_rating, :counter_value_rating, :table_quality_rating, :table_value_rating, :overall_rating, :service_rating, :friendliness_rating, :thumbs_up, :adult_breakfast_menu_url, :adult_lunch_menu_url, :adult_dinner_menu_url, :child_breakfast_menu_url, :child_lunch_menu_url, :child_dinner_menu_url, :requires_credit_card, :requires_pre_payment, :extinct_on, :opened_on, :disney_permalink, :code, :short_name, :accepts_tiw, :accepts_reservations, :kosher_available, :location_details, :operator_id, :operator_url, :operator_type)
    end
end
