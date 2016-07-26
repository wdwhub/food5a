class DfbSync
  attr_accessor :client

 
  def initialize(client: TouringPlansClient.new)
    @client = client
  end
  
  def title
    "touring plans park sync"
  end

  def update_all_venues
  end

  def update_venues#(park_route_key)
    list = DfbVenueFactory::Venue.new.create_summary_dfb_venues
    list.each do |venue|
      updated_venue = update_eatery_from_disneyfoodblog_com(representation: venue.to_h )
      # puts updated_venue
      # puts venue.to_h
    end
  end
  
  def update_eatery_from_disneyfoodblog_com(representation: {}, route: :wdw_dining_review)
    # return "rep is #{representation} and permalink is #{representation[:permalink]}"
    remote_dfb_venue = DfbVenueFactory.for(representation: representation).add_details(route: route)
 
    dfb_eatery             = DfbEatery.where(permalink: remote_dfb_venue.permalink).first_or_create
  # We do not need to have a fallback value because we did that in the parsing and creation of the remote venue
    dfb_eatery.update(
          name:                     remote_dfb_venue.name,
          description:              remote_dfb_venue.description,
          service:                  remote_dfb_venue.service,
          type_of_food:             remote_dfb_venue.type_of_food,
          location:                 remote_dfb_venue.location,
          tables_in_wonderland:     remote_dfb_venue.tables_in_wonderland,
          reviewlinks:              remote_dfb_venue.reviewlinks.to_s,
          important_info:           remote_dfb_venue.important_info,
          you_might_also_like:      remote_dfb_venue.you_might_also_like,
          permalink:                remote_dfb_venue.permalink
    )
    puts "==== #{dfb_eatery.permalink} ==="
    puts dfb_eatery
    puts "======================="
  end
end
  