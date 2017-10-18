class DfbSync
  attr_accessor :client

 
  def initialize(client: TouringPlansClient.new)
    #refactor with update to DfbClient
    @client = client
  end
  
  def title
    #refactor with update to "dfb sync"
    "touring plans park sync"
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
    puts "==== #{dfb_eatery.permalink} ==="
    puts dfb_eatery.name
    puts remote_dfb_venue.reviewlinks
    puts "======================="
    
  # We do not need to have a fallback value because we did that in the parsing and creation of the remote venue
    dfb_eatery.update(
          name:                     remote_dfb_venue.name,
          permalink:                remote_dfb_venue.permalink,
          description:              remote_dfb_venue.description,
          service:                  remote_dfb_venue.service,
          type_of_food:             remote_dfb_venue.type_of_food,
          location:                 remote_dfb_venue.location,
          tables_in_wonderland:     remote_dfb_venue.tables_in_wonderland,
          reviewlinks:              remote_dfb_venue.reviewlinks.to_s,
          important_info:           remote_dfb_venue.important_info,
          you_might_also_like:      remote_dfb_venue.you_might_also_like,
    )
    # if remote_dfb_venue.reviewlinks.to_s.length > 3
    #   remote_dfb_venue.reviewlinks.each do |review|
    #     dfb_article           = dfb_eatery.dfb_articles.where(link: review.href).first_or_create
    #     dfb_article.update(
    #           title:                    review.title,
    #     )
    #
    #   end
    #
    # end
  end
  
  private
  
  def update_review_links
    #add review_links to db
    
  end
end
  