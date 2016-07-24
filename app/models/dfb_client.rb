class DfbClient
  attr_accessor :connection, :routes, :permalink
  # As of 7/20/16, Disney Springs currently does not have a json payload.  It must be scraped.
  DEFAULT_ROUTES = {
    wdw_dining_index: {
      method:   "get",
      path:     "/disney-world-restaurants-guide"
    },
    wdw_dining_review: {
      method:   "get",
      path:     ""
    }
  }
  def initialize(connection: DfbConnection.new, routes: DEFAULT_ROUTES, permalink: nil)
    @connection = connection
    @routes     = routes
    @permalink  = permalink
  end

  def method_missing(method)
    route_map = routes.fetch(method)
    
    http_method   = route_map.fetch(:method)
    section_path  = route_map.fetch(:path) 
    relative_path = permalink.to_s.size > 0 ? [section_path, permalink].join("/") : section_path

    # call the connection for records
    connection.connect(http_method: http_method, relative_path: relative_path)
  end
  
  
end
