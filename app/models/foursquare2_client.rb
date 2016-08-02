require 'foursquare2'
class Foursquare2Client

  DEFAULT_API_VERSION       = "20160609"
  DEFAULT_QUERY             = {}
  DEFAULT_LAT_AND_LNG       = '28.37777,-81.56498'
  DEFAULT_RADIUS            = '6000'
  DEFAULT_FOURSQUARE_ID     = FOURSQUARE_ID
  DEFAULT_FOURSQUARE_SECRET = FOURSQUARE_SECRET
  DEFAULT_VENUE_ID          = ""

  attr_reader :client_id, :client_secret, :ll, :api_version, :radius

  def initialize(api_version: DEFAULT_API_VERSION, 
    query:          DEFAULT_QUERY, 
    ll:             DEFAULT_LAT_AND_LNG, 
    radius:         DEFAULT_RADIUS, 
    client_id:      FOURSQUARE_ID, 
    client_secret:  FOURSQUARE_SECRET, 
    venue_id:       DEFAULT_VENUE_ID)
    
    @api_version =    api_version
    @query =          query
    @ll =             ll
    @radius =         radius 
    @client_id =      client_id 
    @client_secret =  client_secret 
    @venue_id =       venue_id
  end

  def title
    "i am foursquare2"
  end
  
  def client
    client = Foursquare2::Client.new(:client_id => client_id, 
      :client_secret => client_secret, 
      :api_version => api_version, 
      :ll => ll)    
  end
end
