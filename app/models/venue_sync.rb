class VenueSync
  attr_reader :permalinks, :all_venue_ids
  def initialize( permalinks: TouringPlansEatery.all.collect {|venue| venue.permalink},
                  all_venue_ids: Venue.all.collect {|venue| venue.id}
    )
    @permalinks = permalinks
    @all_venue_ids = all_venue_ids
  end

  def title
    "venue sync"
  end
  
  def update_from_touringplans_com(permalink)
      venue = Venue.where(permalink: permalink).first_or_create
      tp_venue = TouringPlansEatery.where(permalink: permalink).first
      permalink = tp_venue.permalink.split("/").last
      venue_default_values  = MissingTouringPlansParkVenue.new
      venue.update(name:            tp_venue.name                     || venue_default_values.name,
        permalink:                  tp_venue.permalink                || venue_default_values.permalink,
        category_code:              tp_venue.category_code            || venue_default_values.category_code,
        portion_size:               tp_venue.portion_size             || venue_default_values.portion_size,
        cost_code:                  tp_venue.cost_code                || venue_default_values.cost_code,
        cuisine:                    tp_venue.permalink                || venue_default_values.permalink,
        phone_number:               tp_venue.phone_number             || venue_default_values.phone_number,
        entree_range:               tp_venue.entree_range             || venue_default_values.entree_range,
        when_to_go:                 tp_venue.when_to_go               || venue_default_values.when_to_go,
        parking:                    tp_venue.parking                  || venue_default_values.parking,
        bar:                        tp_venue.bar                      || venue_default_values.bar,
        wine_list:                  tp_venue.wine_list                || venue_default_values.wine_list,
        dress:                      tp_venue.dress                    || venue_default_values.dress,
        awards:                     tp_venue.awards                   || venue_default_values.awards,
        breakfast_hours:            tp_venue.breakfast_hours          || venue_default_values.breakfast_hours,
        lunch_hours:                tp_venue.lunch_hours              || venue_default_values.lunch_hours,
        dinner_hours:               tp_venue.dinner_hours             || venue_default_values.dinner_hours,
        house_specialties:          tp_venue.house_specialties        || venue_default_values.house_specialties,
        counter_quality_rating:     tp_venue.counter_quality_rating   || venue_default_values.counter_quality_rating,
        counter_value_rating:       tp_venue.counter_value_rating     || venue_default_values.counter_value_rating,
        table_quality_rating:       tp_venue.table_quality_rating     || venue_default_values.table_quality_rating,
        table_value_rating:         tp_venue.table_value_rating       || venue_default_values.table_value_rating,
        overall_rating:             tp_venue.overall_rating           || venue_default_values.overall_rating,
        service_rating:             tp_venue.service_rating           || venue_default_values.service_rating,
        friendliness_rating:        tp_venue.friendliness_rating      || venue_default_values.friendliness_rating,
        thumbs_up:                  tp_venue.thumbs_up                || venue_default_values.thumbs_up,
        adult_breakfast_menu_url:   tp_venue.adult_breakfast_menu_url || \
         venue_default_values.adult_breakfast_menu_url,
        adult_lunch_menu_url:       tp_venue.adult_lunch_menu_url     || venue_default_values.adult_lunch_menu_url,
        adult_dinner_menu_url:      tp_venue.adult_dinner_menu_url    || venue_default_values.adult_dinner_menu_url,
        child_breakfast_menu_url:   tp_venue.child_breakfast_menu_url || \
         venue_default_values.child_breakfast_menu_url,
        child_lunch_menu_url:       tp_venue.child_lunch_menu_url     || venue_default_values.child_lunch_menu_url,
        child_dinner_menu_url:      tp_venue.child_dinner_menu_url    || venue_default_values.child_dinner_menu_url,
        requires_credit_card:       tp_venue.requires_credit_card     || venue_default_values.requires_credit_card,
        requires_pre_payment:       tp_venue.requires_pre_payment     || venue_default_values.requires_pre_payment,
        extinct_on:                 tp_venue.extinct_on               || venue_default_values.extinct_on,
        opened_on:                  tp_venue.opened_on                || venue_default_values.opened_on,
        disney_permalink:           tp_venue.disney_permalink         || venue_default_values.disney_permalink,
        code:                       tp_venue.code                     || venue_default_values.code,
        short_name:                 tp_venue.short_name               || venue_default_values.short_name,
        accepts_tiw:                tp_venue.accepts_tiw              || venue_default_values.accepts_tiw,
        accepts_reservations:       tp_venue.accepts_reservations     || venue_default_values.accepts_reservations,
        kosher_available:           tp_venue.kosher_available         || venue_default_values.kosher_available,
        location_details:           tp_venue.location_details         || venue_default_values.location_details,
        operator_id:                tp_venue.operator_id              || venue_default_values.operator_id,
        operator_url:               tp_venue.operator_url             || venue_default_values.operator_url,
        operator_type:              tp_venue.operator_type            || venue_default_values.operator_type
        
      )
      return venue
  end
  
  def update_all_from_touringplans_com
    permalinks.each do |permalink|
      update_from_touringplans_com(permalink)
    end
  end
  
  def attach_dfb_eatery_to_venue(venue_id)
    permalink = Venue.find(venue_id).permalink
    fastener =     (SPECIALIZED_CLASSES[permalink] || DEFAULT_CLASS ).new
    attachment = VenueFastener.new(venue_id: venue_id, fastener: fastener).fuse_with_resource
  end
  
  def attach_all_dfb_eateries
    all_venue_ids.each do |venue_id|
      attach_dfb_eatery_to_venue(venue_id)
    end
  end

  def attach_foursquare_eatery_to_venue(venue_id)
    permalink = Venue.find(venue_id).permalink
    fastener =     (SPECIALIZED_CLASSES[permalink] || DEFAULT_FOURSQUARE_CLASS ).new
    attachment = VenueFastener.new(venue_id: venue_id, fastener: fastener).fuse_with_resource
  end
  
  def attach_all_foursquare_eateries
    all_venue_ids.each do |venue_id|
      attach_dfb_eatery_to_venue(venue_id)
    end
  end

  DEFAULT_FOURSQUARE_CLASS = FoursquareDefaultVenueFastener  
  
  DEFAULT_CLASS = DfbDefaultVenueFastener
  SPECIALIZED_CLASSES = {
    "normal"                                => DEFAULT_CLASS,
    "french-quarter-pizza"                  => DfbVenueNoMatchFastener, #nothing at dfb matches
    "the-wave-restaurant"                   => DfbVenueMatchByPermalinkFastener,
    "fultons--general-store-market"         => DfbVenueMatchByPermalinkFastener,
    "the-screen-door-market"                => DfbVenueMatchByPermalinkFastener,
    "splash-terrace"                        => DfbVenueMatchByPermalinkFastener,
    "moana-mercantile"                      => DfbVenueMatchByPermalinkFastener,
    "chuck-wagon"                           => DfbVenueMatchByPermalinkFastener,
    "refreshment-outpost-coolpost"          => DfbVenueMatchByPermalinkFastener,
    "fresh-mediterranean-market"            => DfbVenueMatchByPermalinkFastener,
    "private-dining-room-service"           => DfbVenueMatchByPermalinkFastener,
    "saratoga-springs-private-dining"       => DfbVenueMatchByPermalinkFastener,
    "big-top-treats"                        => DfbVenueMatchByPermalinkFastener,
    "settlement-trading-post-market"        => DfbVenueMatchByPermalinkFastener,
    "fittings-farings-market"               => DfbVenueMatchByPermalinkFastener,
    "fittings-farings-market"               => DfbVenueMatchByPermalinkFastener,
    "fresh-mediterranean-market"            => DfbVenueMatchByPermalinkFastener,
    "boma-flavors-of-africa"                => DfbVenueMatchByPermalinkFastener,
    "boatwrights"                           => DfbVenueMatchByPermalinkFastener,

    "oasis-stroller"                        => DfbVenueNoMatchFastener, #nothing at dfb matches
    "panchitos-gifts-sundries-market"       => DfbVenueNoMatchFastener, #nothing at dfb matches
    "sport-goofy-gifts-sundries-market"     => DfbVenueNoMatchFastener, #nothing at dfb matches
    "wilderness-lodge-mercantile-market"    => DfbVenueNoMatchFastener, #nothing at dfb matches
    "surray-bike-rentals-beverages"         => DfbVenueNoMatchFastener, #nothing at dfb matches
    "polynesian-private-dining"             => DfbVenueNoMatchFastener, #nothing at dfb matches
    "fantasmic-food"                        => DfbVenueNoMatchFastener, #nothing at dfb matches
    "big-top-treats"                        => DfbVenueNoMatchFastener, #nothing at dfb matches
    "woodys-round-up"                       => DfbVenueNoMatchFastener, #nothing at dfb matches
    "the-screen-door-market"                => DfbVenueNoMatchFastener, #nothing at dfb matches
    "settlement-trading-post-market"        => DfbVenueNoMatchFastener, #nothing at dfb matches
    "moana-mercantile"                      => DfbVenueNoMatchFastener, #nothing at dfb matches
    "private-dining-room-service"           => DfbVenueNoMatchFastener, #nothing at dfb matches
    "coronado-springs-private-dining"       => DfbVenueNoMatchFastener, #nothing at dfb matches
    "fultons--general-store-market"         => DfbVenueNoMatchFastener, #nothing at dfb matches
    "saratoga-springs-private-dining"       => DfbVenueNoMatchFastener, #nothing at dfb matches
    "fittings-farings-market"               => DfbVenueNoMatchFastener, #nothing at dfb matches
    "johari-treasures"                      => DfbVenueNoMatchFastener, #nothing at dfb matches
    "wild-snacks"                           => DfbVenueNoMatchFastener, #nothing at dfb matches
    "lobby-lounge"                          => DfbVenueNoMatchFastener, #nothing at dfb matches
    "oasis"                                 => DfbVenueNoMatchFastener, #nothing at dfb matches
    "club-cool"                             => DfbVenueNoMatchFastener, #nothing at dfb matches
    "Club-Disney"                           => DfbVenueNoMatchFastener, #nothing at dfb matches
    "Grand-FL-Gingerbread-House"            => DfbVenueNoMatchFastener, #nothing at dfb matches
    "jackson-square-market"                 => DfbVenueNoMatchFastener, #nothing at dfb matches
    "krnr-rock-station"                     => DfbVenueNoMatchFastener, #nothing at dfb matches
    "conch-flats-general-store-market"      => DfbVenueNoMatchFastener, #nothing at dfb matches
    "crush-hot-dog-cart"                    => DfbVenueNoMatchFastener, #nothing at dfb matches
    "refreshment-outpost-coolpost"          => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "chuck-wagon"                           => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "abracadabar"                           => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "the-main-street-confectionary"         => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "jiko-the-cooking-place"                => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "boma-flavors-of-africa"                => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "funnel-cake-kiosk-boardwalk"           => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "java-bar"                              => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "crepes-des-chefs-de-france"            => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "sweet-spells"                          => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "hollywood-and-vine"                    => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "oasis-canteen"                         => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "tortuga-tavern"                        => DfbVenueNoMatchFastener, #exists, but unindexed by dfb
    "herbies-drive-in"                      => DfbVenueNoMatchFastener, #nothing at dfb matches
    "hollywood-scoops"                      => DfbVenueNoMatchFastener, #nothing at dfb matches
    "sandycove-market"                      => DfbVenueNoMatchFastener, #nothing at dfb matches
    
    
    "splash-terrace"                        => DfbVenueNoMatchFastener #exists, but unindexed by dfb
    
  }
  
end
