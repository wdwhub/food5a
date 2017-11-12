class DistrictsIframeController < ApplicationController
  def index
  	@districts = District.all
  end
end
