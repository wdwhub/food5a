module TouringplansVenueFactory
  
  class Venue
    attr_reader :client, :route, :permalink
    
    def initialize(client: TouringPlansClient.new, route: :resort_dining, representation: {})
      @client       = client
      @route        = route
      @permalink    = permalink
    end
    
    def add_details(client:"", route: "")
    end
  end

  
  class TouringplansNormalVenue < Representation

    def add_details(client: TouringPlansClient.new, route: :resort_dining)
      return TouringplansMissingVenue.new if permalink.to_s.length == 0
      client.permalink      = self.permalink
      remote_tp_venue  = TouringPlansVenue.new(client.send(route))
    end
    
  end
  
  class TouringplansExtinctVenue < Representation
  
    def add_details(client: TouringPlansClient.new, route: :resort_dining)
      initial_details = self.to_h
      resulting_hash  = initial_details.merge({:extinct_on => Time.new(2016, 07, 01)})
      TouringPlansVenue.new(resulting_hash)
    end
  end
  
  DEFAULT_CLASS = TouringplansNormalVenue
  
  SPECIALIZED_CLASSES = {
    "normal"                                  => TouringplansNormalVenue,
    "kouzzina-by-cat-cora"                    => TouringplansExtinctVenue
  }
  
  def self.for(permalink)
    (SPECIALIZED_CLASSES[permalink] || DEFAULT_CLASS ).new(representation = {permalink: permalink})
  end
  
end