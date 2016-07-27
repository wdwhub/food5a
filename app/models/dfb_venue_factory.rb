module DfbVenueFactory
  
  class Venue
    attr_reader :client, :route, :permalink
    
    def initialize(client: DfbClient.new, route:'', representation: {}, permalink:'')
      @client       = client
      @route        = route
      @permalink    = permalink
    end
    
    def create_summary_dfb_venues(districts_index = DEFAULT_WDW_DINING_INDEX_NUMBERS)
      # collection.css('p')[30].css('a').collect { |link| {name:link.text, permalink: link['href']}}
      raw_collection  = grab_and_parse_wdw_dining_index_page
      collection_hash_array = districts_index.values.collect { 
        |district_index_number| raw_collection.css('p')[district_index_number]
             .css('a')
             .collect { |link| {name:link.text, permalink: link['href']}
         }
       }
       flattened_hash_array = collection_hash_array.flatten
       filtered_collection = flattened_hash_array.collect do |link|
         {name: filter_name(link[:name], link[:permalink]),
         permalink: link[:permalink]}
       end
       
       venues = filtered_collection.collect { |hash| DfbVenue.new(hash)}
    end
    
    def grab_and_parse_wdw_dining_index_page
      result = client.wdw_dining_index
      result.css('div.entry-content')
    end
    
    def add_details(client:"", route: "")
    end
    
    def filter_name(name, permalink)
      name = name.to_s.strip
      if name.length < 3
        # name = "empty"
        name = permalink.split("disneyfoodblog.com")[1].gsub(/-/, " ").gsub(/\//, "").titleize if name.empty?
      end
      result = name
    end
  end

  
  class DfbNormalVenue < Representation

    def add_details(client: DfbClient.new, route: :wdw_dining_review)
      return DfbMissingVenue.new if permalink.to_s.length == 0
      client.permalink              = self.permalink
      parsable_remote_venue         = client.send(route)
      resulting_hash                = DfbReviewParser.new(parsable_document: parsable_remote_venue).parse_details
      complete_hash                 = ({name: self.name, permalink: self.permalink}).merge(resulting_hash)
      DfbVenue.new(complete_hash)
    end
    
  end
  
  class DfbExtinctVenue < Representation
  
    def add_details(client: "", route: :wdw_dining_review)
      return DfbMissingVenue.new if permalink.to_s.length == 0
      initial_details = self.to_h
      resulting_hash  = initial_details.merge({:extinct_on => Time.new(2016, 07, 01)})
      complete_hash                 = ({name: "#{self.name} (Extinct)", 
        permalink: self.permalink}).merge(resulting_hash)
      DfbVenue.new(complete_hash)
    end
  end
  
  class DfbBadPermalinkVenue < Representation
  
    def add_details(client: "", route: :wdw_dining_review)
      return DfbMissingVenue.new if permalink.to_s.length == 0
      initial_details = self.to_h
      resulting_hash  = initial_details.merge({:description => "permalink not found"})
      complete_hash                 = ({name: "#{self.name} (Bad Permalink)", 
        permalink: self.permalink}).merge(resulting_hash)
      DfbVenue.new(complete_hash)
    end
  end
  
  class DfbBadParsingVenue < Representation
  
    def add_details(client: "", route: :wdw_dining_review)
      return DfbMissingVenue.new if permalink.to_s.length == 0
      initial_details = self.to_h
      resulting_hash  = initial_details.merge({:description => "cannot collect information"})
      complete_hash                 = ({name: "#{self.name} (Bad Permalink)", permalink: self.permalink}).merge(resulting_hash)
      DfbVenue.new(complete_hash)
    end
  end
              
  DEFAULT_CLASS = DfbNormalVenue
  SPECIALIZED_CLASSES = {
    "normal"                                                                              => DfbNormalVenue,
    "http://www.disneyfoodblog.com/tablas-frontera/"                                      => DfbBadPermalinkVenue,
    "http://www.disneyfoodblog.com/team-spirits-pool-bar/"                                => DfbBadPermalinkVenue,
    "http://www.disneyfoodblog.com/2010/09/30/first-look-epcots-new-karamell-kuche/"      => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/2013/09/04/first-look-starbucks-opens-at-epcots-fountain-view-cafe/" => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/2013/05/29/first-look-lartisan-des-glaces-sorbet-and-ice-cream-shop-in-epcots-france-is-open-see-full-menu-and-photos-here/"                               => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/mama-melroses-ristorante-italiano/"                    => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/flame-tree-barbecue/"                                  => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/old-port-royale-food-court/"                           => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/chefs-de-france/"                                      => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/be-our-guest-restaurant/"                              => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/contempo-cafe/"                                        => DfbBadParsingVenue,
    "http://www.disneyfoodblog.com/kouzzina/"                                             => DfbExtinctVenue,
    "http://www.disneyfoodblog.com/el-pirata-y-el-perico/"                                => DfbExtinctVenue,
    "el-pirata-y-el-perico"                                                               => DfbExtinctVenue
  }
   
  DEFAULT_WDW_DINING_INDEX_NUMBERS = {
   magic_kingdom:                      4,
   epcot_future_world:                 5,
   epcot_world_showcase:               6,
   animal_kingdom:                     7,
   disneys_hollywood_studios:          8,
   all_star_movies:                   11,
   all_star_music:                    12,
   all_star_sports:                   13,
   animal_kingdom_lodge_and_villas:   14,
   art_of_animation_resort:           15,
   beach_club:                        16,
   boardwalk:                         17,
   caribbean_beach:                   18,
   contemporary:                      19,
   coronado_springs:                  20,
   dolphin:                           21,
   fort_wilderness:                   22,
   grand_floridian_resort_and_spa:    23,
   old_key_west:                      24,
   polynesian:                        25,
   pop_century:                       26,
   port_orleans_french_quarter:       27,
   port_orleans_riverside:            28,
   saratoga_springs:                  29,
   shades_of_green:                   30,
   swan:                              31,
   wilderness_lodge:                  32,
   yacht_club:                        33,
   disney_springs_marketpalce:        34,
   disney_springs_the_landing:        35,
   disney_springs_town_center:        36,
   disney_springs_west_side:          37,
   blizzard_beach:                    38,
   typhoon_lagoon:                    39,
   espn_wide_world_of_sports:         40
 }
 
 
  
  def self.for(representation: {})
    (SPECIALIZED_CLASSES[representation[:permalink]] || DEFAULT_CLASS ).new(representation)
  end
  
end