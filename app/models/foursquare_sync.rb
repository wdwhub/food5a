class FoursquareSync
  attr_reader :fsq_eatery_default
  
  def initialize (fsq_eatery_default: FoursquareMissingVenue.new)
    @fsq_eatery_default  = fsq_eatery_default
  end
  
  def title
    "foursquare sync"
  end
  
  def collect_all_wdw_venue_names_and_ids
    collection = Venue.all.collect { |venue| {venue_name:venue.name, venue_id:venue.id} }
  end
  
  def collect_all_foursquare_venue_ids
    FoursquareEatery.all.collect { |venue| venue.foursquare_id }
  end
  
  def update_all_foursquare_eateries
    list = collect_all_wdw_venue_names_and_ids
    list.each { |venue| create_or_update_foursquare_eatery(venue_name: venue[:venue_name], venue_id: venue[:venue_id] ) }
    #
    # list = collect_all_cached_attraction_venue_names_and_ids
    # list.each { |venue| create_or_update_cached_venue(cached_attraction_name: "#{venue[:cached_attraction_name]}", cached_attraction_id: venue[:cached_attraction_id])}

    # list.each { |venue| create_or_update_cached_venue(cached_attraction_name: venue[:venue_name], cached_attraction_id: venue[:venue_id] ) }
    
  end
  
  def create_or_update_foursquare_eatery(venue_name: , venue_id:)
    puts     "venue_name: #{venue_name}, venue_id: #{venue_id}"
    
    fsq_eatery_default  = FoursquareMissingVenue.new
    found_remote_fsq_venue    = find_remote_venue(venue_name) || fsq_eatery_default
    return if found_remote_fsq_venue == fsq_eatery_default
    # return
    remote_fsq_venue    = foursquare_venue_representation(found_remote_fsq_venue["id"])
    return fsq_eatery_default if remote_fsq_venue.name.to_s.length <= 3
    remote_fsq_venue_id = remote_fsq_venue.id

    fsq_eatery             = FoursquareEatery.where(foursquare_id: remote_fsq_venue.id).first_or_create

    fsq_eatery.update(name:   remote_fsq_venue.name                     || fsq_eatery_default.name,
       address:               remote_fsq_venue.location.first.address   || fsq_eatery_default.address,
       lat:                   remote_fsq_venue.location.first.lat       || fsq_eatery_default.lat,
       lng:                   remote_fsq_venue.location.first.lng       || fsq_eatery_default.lng,
       wdw_uri:               remote_fsq_venue.url                      || fsq_eatery_default.wdw_uri,
       archived_at:           Time.now,
       canonical_url:         remote_fsq_venue.canonicalUrl             || fsq_eatery_default.canonical_url,
       verified:              remote_fsq_venue.verified                 || fsq_eatery_default.verified,
       # dislike:              remote_fsq_venue.dislike                 || fsq_eatery_default.dislike,
       # ok:              remote_fsq_venue.ok                 || fsq_eatery_default.ok,
       rating:                remote_fsq_venue.rating                     || fsq_eatery_default.rating,
       # rating_color:              remote_fsq_venue.rating_color                 || fsq_eatery_default.rating_color,
       # rating_signals:              remote_fsq_venue.rating_signals                 || fsq_eatery_default.rating_signals,
       # specials:              remote_fsq_venue.specials.first.to_s                 || fsq_eatery_default.specials,
       foursquare_id:         remote_fsq_venue.id.to_s                  || fsq_eatery_default.foursquare_id,
       venue_id:              venue_id                                  || fsq_eatery_default.venue_id
       
     )
     puts "==== sync #{fsq_eatery.foursquare_id} ==="
     # puts "Eatery #{fsq_eatery.name}, address #{fsq_eatery.address}, lat #{fsq_eatery.lat}, lng #{fsq_eatery.lng}, wdw_uri #{fsq_eatery.wdw_uri}, verified #{fsq_eatery.verified}, dislike #{fsq_eatery.dislike}, ok #{fsq_eatery.ok}, rating #{fsq_eatery.rating}, rating_signals #{fsq_eatery.rating_signals}, specials #{fsq_eatery.specials}, wdw_uri #{fsq_eatery.wdw_uri}"
     puts "sync +++++++++++++"
     # puts "remote_fsq_venue #{remote_fsq_venue.name}, address #{remote_fsq_venue.location.first.address}, lat #{remote_fsq_venue.location.first.lat}, lat #{remote_fsq_venue.location.first.lat}, lng #{remote_fsq_venue.location.first.lng}, wdw_uri #{remote_fsq_venue.wdw_uri}, verified #{remote_fsq_venue.verified}, dislike #{remote_fsq_venue.dislike}, ok #{remote_fsq_venue.ok}, rating #{remote_fsq_venue.rating}, rating_signals #{remote_fsq_venue.rating_signals}, specials #{remote_fsq_venue.specials}, wdw_uri #{remote_fsq_venue.url}"
     puts "++++++++++++++"
     puts "remote_fsq_venue #{remote_fsq_venue}"
     puts "======================="
       
  end
  
  def find_remote_venue(venue_name)
    remote_fsq_venue_id = FoursquareVenue.new.search(:query => venue_name).venues.first#[:id]
  end
  
  def foursquare_venue_representation(venue_id)
    FoursquareVenue.new.venue(venue_id)
  end
  
  def create_or_update_cached_photos(venue_id:)
    fsq_photos = FoursquarePhoto.new.venue_photos(venue_id)
    fsq_photos.images.each do |image|
      puts "venue_id: #{venue_id}, cached_photo #{image.id}"
      cached_photo             = CachedPhoto.where(foursquare_photo_id: image.id).first_or_create
      
      cached_photo.update(height:      image.height             || fsq_eatery_default.height,
      created_at_by_epoch:      image.createdAt                 || fsq_eatery_default.created_at_by_epoch,
      width:                    image.width                     || fsq_eatery_default.width,
      foursquare_venue_id:      venue_id                        || fsq_eatery_default.venue_id,
      prefix:                   image.prefix                    || fsq_eatery_default.prefix,
      suffix:                   image.suffix                    || fsq_eatery_default.suffix,
      foursquare_user_name:     image.user.first.firstName.to_s || fsq_eatery_default.foursquare_user_first_name,
      user_icon:                image.user.first.photo          || fsq_eatery_default.foursquare_user_photo,
      visibility:               image.visibility                || fsq_eatery_default.visibility
      )
    end
    
  end

  def create_or_update_cached_tips(venue_id:)
    fsq_tips = FoursquareTip.new.venue_tips(venue_id)
    fsq_tips.tips.each do |tip|
      tip
      puts "===="
      cached_tip             = CachedTip.where(foursquare_tip_id: tip.id).first_or_create
      
      cached_tip.update(foursquare_tip_id:  tip.id   || fsq_eatery_default.foursquare_tip_id,
      text:                           tip.text                        || fsq_eatery_default.text,
      kind:                           tip.type                        || fsq_eatery_default.type,
      foursquare_venue_id:            venue_id                        || fsq_eatery_default.venue_id,
      canonical_url:                  tip.canonical_url               || fsq_eatery_default.canonical_url,
      lang:                           tip.lang                        || fsq_eatery_default.lang,
      foursquare_user_photo_prefix:   tip.user.first.photo_prefix          || fsq_eatery_default.user_photo_prefix,
      foursquare_user_photo_suffix:   tip.user.first.photo_suffix          || fsq_eatery_default.user_photo_suffix,
      foursquare_user_id:             tip.user.first.id          || fsq_eatery_default.foursquare_user_id,
      foursquare_user_first_name:     tip.user.first.first_name  || fsq_eatery_default.foursquare_user_first_name,
      foursquare_last_name:           tip.user.first.last_name  || fsq_eatery_default.foursquare_user_last_name
      )
      # t.string   "foursquare_tip_id"
      # t.text     "text"
      # t.string   "type"
      # t.string   "canonical_url"
      # t.string   "lang"
      # t.string   "likes_count"
      # t.string   "log_view"
      # t.string   "agree_count"
      # t.integer  "foursquare_user_id"
      # t.string   "foursquare_user_first_name"
      # t.string   "foursquare_last_name"
      # t.string   "foursquare_user_gender"
      # t.string   "foursquare_user_photo_prefix"
      # t.string   "foursquare_user_photo_suffix"
      
    end
    
  end
  
  def update_photos_for_all_venues
    list = collect_all_foursquare_venue_ids
    list.each { |venue_id| create_or_update_cached_photos(venue_id: venue_id.to_s)}
  end

  def update_tips_for_all_venues
    list = collect_all_foursquare_venue_ids
    list.each { |venue_id| create_or_update_cached_tips(venue_id: venue_id.to_s)}
  end

end