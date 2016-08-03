# require_relative "./representations/photo"
# require_relative "./representations/user"
# require_relative "./representations/source"

class FoursquareVenue
  
  attr_reader :client, :fsq_default
  def initialize(foursquare_api: Foursquare2Client.new)
    @fsq_default  = foursquare_api
    @client       = foursquare_api.client
  end
  
  # def user(foursquare_user_id)
  #   client.user(foursquare_user_id)
  # end

  def title
    "i am foursquare_venue"
  end
  def venue(venue_id)
    venue = client.venue(venue_id)
    # we choke on arrays that do not have pairs as its elements
    reformated_address                    = reformat_address(venue)
    venue["location"]["formattedAddress"] = reformated_address
    venue["location"]                     = [venue["location"]]
    venue["categories"].each { |category| category["icon"] = [category.fetch("icon")] }
    venue["contact"]                      = [venue.fetch("contact")]
    venue["hours"]                        = [venue["hours"]]
    venue["hereNow"]                      = [venue["hereNow"]]
    
    venue["stats"]                        = [venue.fetch("stats", '')]
    venue["likes"]                        = [venue.fetch("likes", '')]
    venue["price"]                        = [venue.fetch("price", '')]
    venue["menu"]                        = [venue.fetch("menu", '')]

    venue["page"]["pageInfo"]["links"]    = "not needed for wdwhub"
    venue["page"]["pageInfo"]             = [venue.fetch("page").fetch("pageInfo")]
    venue["page"]["user"]                 = "not needed for wdwhub"
    venue["page"]["links"]                = "not needed for wdwhub"
    venue["page"]                         = [venue.fetch("page")]
    venue["photos"]                       = reformat_photos(venue)
    venue["phrases"].each { |phrase| phrase["sample"]  = "not needed for wdwhub" }
    
    venue["specials"]                     = [venue.fetch("specials")]
    venue["tags"]                         = Array(venue.fetch("tags"))
    venue["venueChains"]                  = Array(venue.fetch("venueChains"))
    venue["pageUpdates"]                  = [venue["pageUpdates"]]
    venue["reasons"]                      = [venue["reasons"] ]
    venue["inbox"]                        = [venue["inbox"] ]
    venue["hierarchy"]                    = Array(venue["hierarchy"] )
    venue["tags"]                         = "not needed for wdwhub" #reformat_tips(venue)
    venue["tips"]                         = "not needed for wdwhub" #reformat_tips(venue)
    venue["listed"]                       = "not needed for wdwhub"
    venue["popular"]                      = "complex, come back later"
    venue["parent"]                       = "not needed for wdwhub"
    venue["attributes"]                   = "not needed for wdwhub"
    venue["bestPhoto"]                    = [reformat_best_photo(venue["bestPhoto"])]
    result = venue
    # response = Representation.new(result)
    
  end
  
  def search(ll: fsq_default.ll, query: "")
    # ll = lng lat
    client.search_venues(:ll => ll, :query => query)
  end
  
  def tips(venue_id:, query: "")
    client.venue_tips(venue_id: venue_id, query: query)
  end

  def photos(venue_id:, query: "")
    venue = client.venue(venue_id)
    photos = venue.fetch("photos").fetch("groups").fetch(0).fetch("items")
    photos.each { |item| item["source"] = [item.fetch("source")]}
    photos.each { |item| item["user"]["photo"] = [item.fetch("user").fetch("photo")]}
    photos.each { |item| item["user"] = [item.fetch("user")]}
    
    response = Representation.new({"photos" => photos })
    
  end
  
  def reformat_best_photo(photo)
    photo['source'] = [photo.fetch("source")]
    photo
    # photos.each { |item| item["user"]["photo"] = [item.fetch("user").fetch("photo")]}
    # photos.each { |item| item["user"] = [item.fetch("user")]}
  end

  def reformat_photos(venue)
    photos = venue.fetch("photos").fetch("groups").fetch(0).fetch("items")
    photos.each { |item| item["source"] = [item.fetch("source")]}
    photos.each { |item| item["user"]["photo"] = [item.fetch("user").fetch("photo")]}
    photos.each { |item| item["user"] = [item.fetch("user")]}
  end

  def reformat_tips(venue)
    tips = venue.fetch("tips").fetch("groups").fetch(0).fetch("items")
    tips.each { |item| item["likes"] = "not needed for wdwhub"}
    tips.each { |item| item["todo"] = "not needed for wdwhub"}
    tips.each { |item| item["user"] = "not needed for wdwhub"}
    tips.each { |item| item["photo"] = "not needed for wdwhub"}
    tips
  end
  
  def reformat_address(venue)
    venue.fetch("location", "").fetch("formattedAddress", "").join(", ")
  end
  
end