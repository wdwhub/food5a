require_relative "./representations/tip"
require_relative "./representations/user"

class FoursquareTip
  attr_reader :client, :fsq_default_settings, :fsq_venue_default
  
  def initialize(foursquare_api: Foursquare2Client.new, fsq_venue_default: FoursquareMissingVenue.new)
    @fsq_default_settings   = foursquare_api
    @fsq_venue_default      = fsq_venue_default
    @client                 = foursquare_api.client
  end

  def title
    "i am foursquare_tip"
  end
  
  def venue_tips(venue_id)
    response = client.venue_tips(venue_id)
    response["tips"] = []
    response["super_tips"] = response.fetch("items", [])
    response.delete("items") if response.fetch("items").length > 0
    response["super_tips"].each do |tip|
      tip["id"]     = tip.fetch("id", "")
      tip["likes"]     = _reformat_likes(tip["likes"])
      tip["todo"]      = _reformat_todo(tip["todo"])
      tip["user"]      = _reformat_user(tip["user"])
      tip["photo"]     = _reformat_photo(tip["photo"]) if tip["photo"]
      tip["entities"]  = _reformat_photo(tip["entities"]) if tip["entities"]
      tip["photourl"]  = "this is the photourl" if tip["photourl"]
      response["tips"] << {
        "id"            => tip.fetch("id", ""),
        "text"          => tip.fetch("text", ""),
        "text"          => tip.fetch("text", ""),
        "agreeCount"    => tip.fetch("agreeCount", ""),
        "user"          => tip.fetch("user", "")
      }
    end
    response.delete("super_tips") if response.fetch("super_tips").length > 0
    
    puts "==============="
    puts response
    puts "+++++++++++++++"
    response 
    result = Representation.new(response)
    
  end

  private
  
  def _reformat_likes(likes)
    likes_hash = Hash.new
    likes_hash["ready"] = "not_yet"
    result = [likes_hash]
  end

  def _reformat_todo(todo)
    todos_hash = Hash.new
    todos_hash["ready"] = "not_yet"
    result = [todos_hash]
  end

  def _reformat_user(user)
    user_hash = Hash.new
    # user_hash = user
    user_hash["id"]         = user["id"]
    user_hash["first_name"] = user.fetch("firstName", '')
    user_hash["last_name"]  = user.fetch("lastName", '')
    user_hash["photo_prefix"] = user.fetch("photo", '').fetch("prefix", '')
    user_hash["photo_suffix"] = user.fetch("photo", '').fetch("suffix", '')
    # user_hash["photo"] = [user.fetch("photo", '')]
    result = [user_hash]
  end

  def _reformat_photo(photo)
    photo_hash = Hash.new
    photo_hash["ready"] = "not_yet"
    result = [photo_hash]
  end
  
  def _reformat_entities
    entities_hash = Hash.new
    entities_hash["ready"] = "not_yet"
    result = [entities_hash]    
  end

  def _reformat_photourl
    photourl_hash = Hash.new
    photourl_hash["ready"] = "not_yet"
    result = [photourl_hash]    
  end
end
