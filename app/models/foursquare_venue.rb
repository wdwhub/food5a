# require_relative "./representations/photo"
# require_relative "./representations/user"
# require_relative "./representations/source"

class FoursquareVenue
  
  attr_reader :client, :fsq_venue_default, :fsq_default_settings
  def initialize(foursquare_api: Foursquare2Client.new, fsq_venue_default: FoursquareMissingVenue.new)
    @fsq_venue_default      = fsq_venue_default
    @fsq_default_settings   = foursquare_api
    @client                 = foursquare_api.client
  end
  
  # def user(foursquare_user_id)
  #   client.user(foursquare_user_id)
  # end

  def title
    "i am foursquare_venue"
  end
  def venue(venue_id)
    venue = client.venue(venue_id)
    fsq_venue_default  = FoursquareMissingVenue.new
    puts "============ start #{venue_id} ============"
    puts venue
    puts "+++++++++++++++++++++++++++++++++++++++++++"
    # we choke on arrays that do not have at least one hash as its elements

    location_hash                         = venue.fetch("location", {})
    venue["location"]                     = reformat_location(location_hash)
    
    venue["categories"]                   = "complex, come back later" #.each { |category| category["icon"] = "not needed for wdwhub"} #[category.fetch("icon")] }
    venue["contact"]                      = "complex, come back later" #[venue.fetch("contact")]
    venue["hours"]                        = "complex, come back later" #[venue["hours"]]
    venue["hereNow"]                      = "complex, come back later" #[venue["hereNow"]]
    
    venue["stats"]                        = "complex, come back later" #[venue.fetch("stats", '')]
    venue["likes"]                        = "not needed for wdwhub" #[venue.fetch("likes", '')]
    venue["price"]                        = "complex, come back later" #[venue.fetch("price", '')]
    venue["menu"]                         = "complex, come back later" #[venue.fetch("menu", '')]
    venue["verified"]                     = venue.fetch("verified", fsq_venue_default.verified)#"complex, come back later"

    # venue["page"]["pageInfo"]["links"]    = "not needed for wdwhub" || fsq_venue_default.links
    # venue["page"]["pageInfo"]             = [venue.fetch("page").fetch("pageInfo")]
    # venue["page"]["user"]                 = "not needed for wdwhub"
    # venue["page"]["links"]                = "not needed for wdwhub"
    venue["venuePage"]                    = "not needed for wdwhub"
    venue["page"]                         = "not needed for wdwhub"
    venue["photos"]                       = "not needed for wdwhub" #
    venue["phrases"]                      = "not needed for wdwhub right now"
    
    venue["specials"]                     = "not needed for wdwhub" #[venue.fetch("specials")]
    venue["tags"]                         = "not needed for wdwhub" #Array(venue.fetch("tags"))
    venue["venueChains"]                  = "not needed for wdwhub" #Array(venue.fetch("venueChains"))
    venue["pageUpdates"]                  = "not needed for wdwhub" #[venue["pageUpdates"]]
    venue["reasons"]                      = "not needed for wdwhub" #[venue["reasons"] ]
    venue["inbox"]                        = "not needed for wdwhub" #[venue["inbox"] ]
    venue["hierarchy"]                    = "not needed for wdwhub" #Array(venue["hierarchy"] )
    venue["tags"]                         = "not needed for wdwhub" #reformat_tips(venue)
    venue["tips"]                         = "not needed for wdwhub" #reformat_tips(venue)
    venue["listed"]                       = "not needed for wdwhub"
    venue["popular"]                      = "complex, come back later"
    venue["parent"]                       = "not needed for wdwhub"
    venue["attributes"]                   = "not needed for wdwhub"
    best_photo_hash                       = venue.fetch("bestPhoto", {})
    venue["bestPhoto"]                    = reformat_best_photo(best_photo_hash)
    result = venue
    response = Representation.new(result)
    
  end
  
  def search(ll: fsq_default_settings.ll, query: "")
    # ll = lng lat
    client.search_venues(:ll => ll, :query => query)
  end
  
  def tips(venue_id:, query: "")
    client.venue_tips(venue_id: venue_id, query: query)
  end

  def photos(venue_id:, query: "")
    venue = client.venue(venue_id)
    photos = venue.fetch("photos").fetch("groups").fetch(0).fetch("items")
    photos.each { |item| item["source"] = "not needed for wdwhub"} #[item.fetch("source")]}
    photos.each { |item| item["user"]["photo"] = "not needed for wdwhub" }#[item.fetch("user").fetch("photo")]}
    photos.each { |item| item["user"] = "not needed for wdwhub"} #[item.fetch("user")]}
    
    response = Representation.new({"photos" => photos })
    
  end
  
  def reformat_location(location_hash)
    # return [{"unfinished" => true}]
    reformatted_location_hash                = Hash.new
    
    reformatted_location_hash["address"]          = location_hash.fetch("address", fsq_venue_default.address)
    reformatted_location_hash["crossStreet"]      = location_hash.fetch("crossStreet", fsq_venue_default.cross_street)
    reformatted_location_hash["postalCode"]       = location_hash.fetch("postalCode", fsq_venue_default.postal_code)
    reformatted_location_hash["cc"]               = location_hash.fetch("cc", fsq_venue_default.cc)
    reformatted_location_hash["city"]             = location_hash.fetch("city", fsq_venue_default.city)#"complex, come back later"
    reformatted_location_hash["state"]            = location_hash.fetch("state", fsq_venue_default.state)#"complex, come back later"
    reformatted_location_hash["country"]          = location_hash.fetch("country", fsq_venue_default.country)#"complex, come back later"
    reformatted_location_hash["formattedAddress"] = "complex, come back later" #reformated_address
    reformatted_location_hash["lat"]              = location_hash.fetch("lat", fsq_venue_default.lat)#"complex, come back later" #reformated_address
    reformatted_location_hash["lng"]              = location_hash.fetch("lng", fsq_venue_default.lng)#"complex, come back later" #reformated_address
    result = [reformatted_location_hash]
  end
  
  def reformat_best_photo(photo_hash)
    # createdAt=1334247586 height=720 id="4f8700a2e4b0474330959ccc" prefix="https://irs1.4sqi.net/img/general/" source=#<Hashie::Mash name="Foursquare for Android" url="https://foursquare.com/download/#/android"> suffix="/p7Rlw1cT9LIhcqlzDSohGSF7SUj9U1V35S7_0E69HDE.jpg" visibility="public" width=540>
    # return [{"incomplete" => true}]
    reformatted_photo_hash                = Hash.new
    reformatted_photo_hash['createdAt']   = photo_hash.fetch('createdAt', '')
    reformatted_photo_hash['height']                  = photo_hash.fetch('height', '')#"not needed for wdwhub" 
    reformatted_photo_hash['width']                   = photo_hash.fetch('width', '')#"not needed for wdwhub" 
    reformatted_photo_hash['id']                      = photo_hash.fetch('id', '')#"not needed for wdwhub" #[photo.fetch("source")]
    reformatted_photo_hash['visibility']              = photo_hash.fetch('visibility', 'public')#"not needed for wdwhub"
    reformatted_photo_hash['source']                  ="not needed for wdwhub"# photo_hash.fetch('source', 'source')# 
    reformatted_photo_hash['prefix']                  = photo_hash.fetch('prefix', 'prefix')# 
    reformatted_photo_hash['suffix']                  = photo_hash.fetch('suffix', 'prefix')# 
    # photo_hash['user']        = "not needed for wdwhub"
    result = [reformatted_photo_hash]
    # photos.each { |item| item["user"]["photo"] = [item.fetch("user").fetch("photo")]}
    # photos.each { |item| item["user"] = [item.fetch("user")]}
  end

  def reformat_photos(venue)
    photos = "currently too complicated for wdwhub" #venue.fetch("photos").fetch("groups").fetch(0).fetch("items")
    # photos.each { |item| item["source"]         =  "not needed for wdwhub"} #[item.fetch("source")]}
    # photos.each { |item| item["user"]["photo"]  =  "not needed for wdwhub"} #[item.fetch("user").fetch("photo")]}
    # photos.each { |item| item["user"]           =  "not needed for wdwhub"} #[item.fetch("user")]}
  end

  def reformat_tips(venue)
    tips = venue.fetch("tips").fetch("groups").fetch(0).fetch("items")
    tips.each { |item| item["likes"]  = "not needed for wdwhub"}
    tips.each { |item| item["todo"]   = "not needed for wdwhub"}
    tips.each { |item| item["user"]   = "not needed for wdwhub"}
    tips.each { |item| item["photo"]  = "not needed for wdwhub"}
    tips
  end
  
  def reformat_address(venue)
    venue.fetch("location", "").fetch("formattedAddress", "").join(", ")
  end
  
end