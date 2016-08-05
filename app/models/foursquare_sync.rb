class FoursquareSync
  def initialize (fsq_eatery_default: FoursquareMissingVenue.new)
    @fsq_eatery_default  = fsq_eatery_default
  end
  
  def title
    "foursquare sync"
  end
  
  def collect_all_wdw_venue_names
    names_collection = Venue.all.collect { |venue| venue.name }
  end
  
  def collect_all_foursquare_venue_ids
    FoursquareEatery.all.collect { |venue| venue.foursquare_id }
  end
  
  def update_all_foursquare_eateries
    list = collect_all_wdw_venue_names
    list.each { |name| create_or_update_foursquare_eatery(venue_name: name.to_s ) }
  end
  def create_or_update_foursquare_eatery(venue_name: )
    fsq_eatery_default  = FoursquareMissingVenue.new
    found_remote_fsq_venue    = find_remote_venue(venue_name) || fsq_eatery_default
    return if found_remote_fsq_venue == fsq_eatery_default
    remote_fsq_venue    = foursquare_venue_representation(found_remote_fsq_venue["id"])
    return fsq_eatery_default if remote_fsq_venue.name.to_s.length <= 3
    remote_fsq_venue_id = remote_fsq_venue.id

    fsq_eatery             = FoursquareEatery.where(foursquare_id: remote_fsq_venue.id).first_or_create

    fsq_eatery.update(name:   remote_fsq_venue.name                     || fsq_eatery_default.name,
       address:               remote_fsq_venue.location.first.address             || fsq_eatery_default.address,
       lat:                   remote_fsq_venue.location.first.lat                 || fsq_eatery_default.lat,
       lng:                   remote_fsq_venue.location.first.lng                 || fsq_eatery_default.lng,
       wdw_uri:               remote_fsq_venue.url                      || fsq_eatery_default.wdw_uri,
       archived_at:           Time.now,
       canonical_url:         remote_fsq_venue.canonicalUrl             || fsq_eatery_default.canonical_url,
       verified:              remote_fsq_venue.verified                 || fsq_eatery_default.verified,
       # dislike:              remote_fsq_venue.dislike                 || fsq_eatery_default.dislike,
       # ok:              remote_fsq_venue.ok                 || fsq_eatery_default.ok,
       rating:              remote_fsq_venue.rating                 || fsq_eatery_default.rating,
       # rating_color:              remote_fsq_venue.rating_color                 || fsq_eatery_default.rating_color,
       # rating_signals:              remote_fsq_venue.rating_signals                 || fsq_eatery_default.rating_signals,
       # specials:              remote_fsq_venue.specials.first.to_s                 || fsq_eatery_default.specials,
       foursquare_id:              remote_fsq_venue.id.to_s                 || fsq_eatery_default.foursquare_id
       
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
      cached_photo             = CachedPhoto.where(foursquare_photo_id: image.id).first_or_create
      
      cached_photo.update(height:      image.height         || fsq_eatery_default.height,
      created_at_by_epoch:      image.createdAt             || fsq_eatery_default.created_at_by_epoch,
      width:                    image.width                 || fsq_eatery_default.width,
      foursquare_venue_id:      venue_id                    || fsq_eatery_default.venue_id,
      prefix:                   image.prefix                || fsq_eatery_default.prefix,
      suffix:                   image.suffix                || fsq_eatery_default.suffix,
      fousquare_user:           image.fousquare_user.to_s   || fsq_eatery_default.fousquare_user,
      visibility:               image.visibility            || fsq_eatery_default.visibility
      )
    end
    
  end
  
  def update_photos_for_all_venues
    list = collect_all_foursquare_venue_ids
    list.each { |venue_id| create_or_update_cached_photos(venue_id: venue_id.to_s)}
  end
end