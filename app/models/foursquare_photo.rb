require_relative "./representations/photo"

class FoursquarePhoto
  attr_reader :client, :fsq_default
  def initialize(foursquare_api: Foursquare2Client.new)
    @fsq_default  = foursquare_api
    @client       = foursquare_api.client
  end

  def title
    "i am foursquare_photo"
  end
  
  def venue_photos(venue_id)
    response = client.venue_photos(venue_id)
    response["photos"] = response.delete("items")
    response["photos"].each { |item|  item["source"] = _reformat_source(item["source"])}
    response["photos"].each { |item|  item["user"] = _reformat_user(item["user"])}
    
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
    "not currently needed"
    # source_hash = Hash.new
    # source_hash[:name] = source.fetch('name', '')
    # source_hash[:url] = source.fetch('url', '')
    # result = [source_hash]
  end
end
