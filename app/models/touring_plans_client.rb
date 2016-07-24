class TouringPlansClient
  attr_accessor :connection, :routes, :permalink
  # As of 7/20/16, Disney Springs currently does not have a json payload.  It must be scraped.
  DEFAULT_ROUTES = {
    magic_kingdom: {
      method:   "get",
      path:     "magic-kingdom/dining"
    },
    epcot: {
      method:   "get",
      path:     "epcot/dining"
    },
    hollywood_studios: {
      method:   "get",
      path:     "hollywood-studios/dining"
    },
    animal_kingdom: {
      method:   "get",
      path:     "animal-kingdom/dining"
    },
    typhoon_lagoon: {
      method:   "get",
      path:     "typhoon-lagoon/dining"
    },
    blizzard_beach: {
      method:   "get",
      path:     "blizzard-beach/dining"
    },
    resort_dining_index: {
      method:   "get",
      path:     "walt-disney-world/resort-dining"
    },
    resort_dining: {
      method:   "get",
      path:     "walt-disney-world/dining"
    }
  }
  def initialize(connection: TouringPlansConnection.new, routes: DEFAULT_ROUTES, permalink: nil)
    @connection = connection
    @routes     = routes
    @permalink  = permalink
  end

  def method_missing(method)
    route_map = routes.fetch(method)
    
    http_method   = route_map.fetch(:method)
    section_path  = route_map.fetch(:path) 
    relative_path = permalink.to_s.size > 0 ? [section_path, permalink].join("/") : section_path
    extension     = ".json"

    # call the connection for records
    connection.connect(http_method: http_method, relative_path: relative_path, extension: extension)
  end
  
end