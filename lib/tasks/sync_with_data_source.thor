require "./config/environment"

class Admin < Thor

  desc "update_site", "general command to update site from all sources"
  def update_site
    say "Updating Touring Plans reviews…", :blue
    sleep(1)
    TouringPlansSync.new.update_all_venues

    say "Updating Foursquare venues…", :blue
    sleep(1)
    FoursquareSync.new.update_all_foursquare_eateries

    say "Updating Foursquare photos…", :blue
    sleep(1)
    FoursquareSync.new.update_photos_for_all_venues

    say "Updating Foursquare tips…", :blue
    sleep(1)
    FoursquareSync.new.update_tips_for_all_venues

    say "Updating Disney Food Blog venues…", :blue
    sleep(1)
    DfbSync.new.update_venues

    say "Updating Disney Food Blog venues…", :blue
    sleep(1)
    vs = VenueSync.new
    say "Updating venues with cached data from touringplans.com", :green
    vs.update_all_from_touringplans_com
    say "Updating venues with with cached data from foursquare.com", :green
    vs.attach_all_foursquare_eateries
    say "Updating venues with cached data from disneyfoodblog.com", :green
    vs.attach_all_dfb_eateries

    say "DONE", :yellow

  end  

end

class SyncWithDataSource < Thor
  
  desc "touring_plans", "sync cached records with touringplans.com"
  def touring_plans
    say "Updating Touring Plans reviews…", :blue
    TouringPlansSync.new.update_all_venues
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

  desc "dfb_venues", "sync cached records with disneyfoodblog.com"
  def dfb_venues
    say "Updating Disney Food Blog venues…", :blue
    DfbSync.new.update_venues
  end

  desc "eatery_venues", "sync and connect displayed venues with cached data from DFB, touring_plans, and foursquare"
  def eatery_venues
    say "Updating Disney Food Blog venues…", :blue
    vs = VenueSync.new
    say "Updating venues with cached data from touringplans.com", :green
    vs.update_all_from_touringplans_com
    say "Updating venues with with cached data from foursquare.com", :green
    vs.attach_all_foursquare_eateries
    say "Updating venues with cached data from disneyfoodblog.com", :green
    vs.attach_all_dfb_eateries

    say "DONE", :yellow
  end

end