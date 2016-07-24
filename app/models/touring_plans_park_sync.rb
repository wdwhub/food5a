class TouringPlansParkSync
  attr_accessor :client
  
  def initialize(client: TouringPlansClient.new)
    @client = client
  end
  
  def title
    "touring plans park sync"
  end

  def update_all_venues
    update_all_resort_venues
    update_all_park_venues
  end
  
  def update_all_resort_venues
    list = list_resort_venues(route: :resort_dining_index)
    list.collect do |resort|
      puts "++++++++  #{resort.name} ++++++++++"
      update_the_venues_of_a_resort(route: :resort_dining, resort: resort)
    end
  end

  def update_the_venues_of_a_resort(route: :resort_dining, resort:)
    # tps = TouringPlansParkSync.new;tps.client.permalink = "intermission-food-court";tps.client.send(:resort_dining)
    
    resort.dinings.each do |venue|
      updated_venue = update_eatery_from_touringplans_com(route: :resort_dining, representation: {name: venue.name, permalink: venue.permalink} )
      puts updated_venue
    end
  end

  def update_all_park_venues
    park_routes_keys.each do |park_route_key|
      update_park_venues(park_route_key)
    end
  end

  def update_park_venues(park_route_key)
    list = list_park_venues(route: park_route_key)
    # list.collect { |venue| venue.name }
    list.each do |venue|
      updated_venue = update_eatery_from_touringplans_com(route: park_route_key, representation: {name: venue.name, permalink: venue.permalink} )
      puts updated_venue
    end
  end

  def update_eatery_from_touringplans_com(route:, representation: {})
    # return "route is #{route} and rep is #{representation} and permalink is #{representation[:permalink]}"
    tp_eatery_default     = TouringplansMissingVenue.new
    return tp_eatery_default if representation[:permalink].to_s.length == 0
    remote_tp_park_venue = TouringplansVenueFactory.for(representation: representation).add_details(route: route)

    tp_eatery             = TouringPlansEatery.where(permalink: remote_tp_park_venue.permalink).first_or_create
    
    tp_eatery.update(name:      remote_tp_park_venue.name                       || tp_eatery_default.name,
       category_code:           remote_tp_park_venue.category_code              || tp_eatery_default.category_code,
       dress:                   remote_tp_park_venue.dress                      || tp_eatery_default.dress,
       awards:                  remote_tp_park_venue.awards                     || tp_eatery_default.awards,
       breakfast_hours:         remote_tp_park_venue.breakfast_hours            || tp_eatery_default.breakfast_hours,
       lunch_hours:             remote_tp_park_venue.lunch_hours                || tp_eatery_default.lunch_hours,
       dinner_hours:            remote_tp_park_venue.dinner_hours               || tp_eatery_default.dinner_hours,
       house_specialties:       remote_tp_park_venue.house_specialties          || tp_eatery_default.house_specialties,
       counter_quality_rating:  remote_tp_park_venue.counter_quality_rating     || tp_eatery_default.counter_quality_rating,
       counter_value_rating:  remote_tp_park_venue.counter_value_rating         || tp_eatery_default.counter_value_rating,
       table_quality_rating:  remote_tp_park_venue.table_quality_rating         || tp_eatery_default.table_quality_rating,
       overall_rating:  remote_tp_park_venue.overall_rating                     || tp_eatery_default.overall_rating,
       service_rating:  remote_tp_park_venue.service_rating                     || tp_eatery_default.service_rating,
       friendliness_rating:  remote_tp_park_venue.friendliness_rating           || tp_eatery_default.friendliness_rating,
       thumbs_up:  remote_tp_park_venue.thumbs_up                               || tp_eatery_default.thumbs_up,
       adult_breakfast_menu_url:  remote_tp_park_venue.adult_breakfast_menu_url || tp_eatery_default.adult_breakfast_menu_url,
       adult_dinner_menu_url:  remote_tp_park_venue.adult_dinner_menu_url       || tp_eatery_default.adult_dinner_menu_url,
       child_breakfast_menu_url:  remote_tp_park_venue.child_breakfast_menu_url || tp_eatery_default.child_breakfast_menu_url,
       child_dinner_menu_url:  remote_tp_park_venue.child_dinner_menu_url       || tp_eatery_default.child_dinner_menu_url,

       requires_credit_card:  remote_tp_park_venue.requires_credit_card         || tp_eatery_default.requires_credit_card,
       requires_pre_payment:  remote_tp_park_venue.requires_pre_payment         || tp_eatery_default.requires_pre_payment,
       extinct_on:  remote_tp_park_venue.extinct_on                             || tp_eatery_default.extinct_on,

       opened_on:  remote_tp_park_venue.opened_on                               || tp_eatery_default.opened_on,
       disney_permalink:  remote_tp_park_venue.disney_permalink                 || tp_eatery_default.disney_permalink,
       code:  remote_tp_park_venue.code                                         || tp_eatery_default.code,

       short_name:  remote_tp_park_venue.short_name                             || tp_eatery_default.short_name,
       accepts_tiw:  remote_tp_park_venue.accepts_tiw                           || tp_eatery_default.accepts_tiw,
       accepts_reservations:  remote_tp_park_venue.accepts_reservations         || tp_eatery_default.accepts_reservations,

       dinable_id:            remote_tp_park_venue.dinable_id                   || tp_eatery_default.dinable_id,
       dinable_type:          remote_tp_park_venue.dinable_type                 || tp_eatery_default.dinable_type,


       kosher_available:  remote_tp_park_venue.kosher_available                 || tp_eatery_default.kosher_available,
       location_details:  remote_tp_park_venue.location_details                 || tp_eatery_default.location_details,
       operator_id:  remote_tp_park_venue.operator_id                           || tp_eatery_default.operator_id,
       operator_url:  remote_tp_park_venue.operator_url                         || tp_eatery_default.operator_url,
       operator_type:       remote_tp_park_venue.operator_type                  || tp_eatery_default.operator_type
     )
     puts "==== #{tp_eatery.permalink} ==="
     puts tp_eatery
     puts "======================="
     
  end

  def list_park_venues(route:)
    client.permalink        = ""
    result                  = client.send(route)
    list                    = Array(result).flatten
    list_of_representations = list.collect { |venue| TouringPlansParkVenue.new(venue)  }
  end
  
  def list_resort_venues(route: :resort_dining_index)
    client.permalink        = ""
    result                  = client.resort_dining_index
    list                    = Array(result).flatten
    list_of_representations = list.collect { |venue| TouringPlansResort.new(venue)  }
  end

  def park_routes_keys
    client.routes.keys.find_all { |i|  i != :resort_dining }.find_all { |i|  i != :resort_dining_index }
  end
end