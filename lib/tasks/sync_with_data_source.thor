require "./config/environment"

class SyncWithDataSource < Thor
  
  desc "touring_plans", "sync cached records with touringplans.com"
  def touring_plans
    say "Updating Touring Plans reviews…", :blue
    TouringplansSync.new.update_all_venues
  end
  
  desc "foursquare_venues", "sync cached records with foursquare.com"
  def foursquare_venues
    say "Updating Foursquare venues…", :blue
    FoursquareSync.new.update_all_foursquare_eateries
  end

  desc "foursquare_photos", "sync cached photos with foursquare.com"
  def foursquare_photos
    say "Updating Foursquare photos…", :blue
    FoursquareSync.new.update_photos_for_all_venues
  end

  desc "foursquare_tips", "sync cached tips with foursquare.com"
  def foursquare_tips
    say "Updating Foursquare tips…", :blue
    FoursquareSync.new.update_tips_for_all_venues
  end

end