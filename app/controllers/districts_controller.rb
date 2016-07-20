class DistrictsController < ApplicationController
  before_action :set_district, only: [:show, :edit, :update, :destroy]

  # GET /districts
  def index
    @districts = District.all
  end

  # GET /districts/1
  def show
  end

  # GET /districts/new
  def new
    @district = District.new
  end

  # GET /districts/1/edit
  def edit
  end

  # POST /districts
  def create
    @district = District.new(district_params)

    if @district.save
      redirect_to @district, notice: 'District was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /districts/1
  def update
    if @district.update(district_params)
      redirect_to @district, notice: 'District was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /districts/1
  def destroy
    @district.destroy
    redirect_to districts_url, notice: 'District was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district
      @district = District.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def district_params
      params.require(:district).permit(:name, :permalink, :is_park, :credit, :photo_url, :flickr_search_term, :published_at, :wdw_uri)
    end
end
