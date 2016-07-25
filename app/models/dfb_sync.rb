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
      puts updated_venue
      # puts venue.to_h
    end
  end
  
  def update_eatery_from_disneyfoodblog_com(representation: {}, route: :wdw_dining_review)
    # return "rep is #{representation} and permalink is #{representation[:permalink]}"
    remote_dfb_venue = DfbVenueFactory.for(representation: representation).add_details(route: route)
  #
  #   dfb_eatery             = DfbEatery.where(permalink: remote_dfb_venue.permalink).first_or_create
  #
  #   dfb_eatery.update(name:     remote_dfb_venue.name                       || dfb_eatery_default.name,
  #     operator_type:            remote_dfb_venue.operator_type              || dfb_eatery_default.operator_type
  #   )
  # puts "==== #{dfb_eatery.permalink} ==="
  # puts dfb_eatery
  # puts "======================="
  #
  # def list_resort_venues(route: :resort_dining_index)
  #   client.permalink        = ""
  #   results                  = client.wdw_dining_index
  #   ## what returns in result needs further parsing
  #   list                    = Array(result).flatten
  #   list_of_representations = list.collect { |venue| DfbVenue.new(venue)  }
  # end
  #
  # def list_magic_kingdom_venues(results: client.wdw_dining_index)
  #   parsable_document = results.css('p')[4].css('a')
  #   links = parsable_document.collect { |link| {name: link.text, permalink: link['href']}}
  #   magic_kindom_venues = links.collect { |venue| DfbVenue.new(venue)}
  # end
  #
  # def list_magic_kingdom_venues(results: client.wdw_dining_index)
  #   parsable_document = results.css('p')[4].css('a')
  #   links = parsable_document.collect { |link| {name: link.text, permalink: link['href']}}
  #   magic_kindom_venues = links.collect { |venue| DfbVenue.new(venue)}
  end
  
end
