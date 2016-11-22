require_relative "./representations/image"

class FoursquarePhoto
  attr_reader :client, :fsq_default_settings, :fsq_venue_default
  
  def initialize(foursquare_api: Foursquare2Client.new, fsq_venue_default: FoursquareMissingVenue.new)
    @fsq_default_settings   = foursquare_api
    @fsq_venue_default      = fsq_venue_default
    @client                 = foursquare_api.client
  end

  def title
    "i am foursquare_photo"
  end
  
  def venue_photos(venue_id)
    response = client.venue_photos(venue_id)
    response["images"] = response.fetch("items", [])
    response.delete("items") if response.fetch("items").length > 0
    response["images"].each { |item|  item["source"] = _reformat_source(item["source"])}
    response["images"].each { |item|  item["user"] = _reformat_user(item["user"])}
    
    # puts "==============="
    # puts response
    # puts "+++++++++++++++"
    result = Representation.new(response)
    
  end

  private
  
  def _reformat_source(source)
    source_hash = Hash.new
    source_hash[:name] = source.fetch('name', '')
    source_hash[:url] = source.fetch('url', '')
    result = [source_hash]
  end
  
  def _reformat_user(user)
    # "not currently needed"
    user_hash = Hash.new
    user_hash[:firstName]     = user.fetch('firstName', '')
    user_hash[:lastName]      = user.fetch('lastName', '')
    user_hash[:photo]         = user.fetch('photo', '').fetch('prefix', '')
    user_hash[:photo]         << "100x100"
    user_hash[:photo]         << user.fetch('photo', '').fetch('suffix', '')
    result = [user_hash]
    
    # result = "#{user_hash[:firstName]} #{user_hash[:lastName]}"
  end

end
