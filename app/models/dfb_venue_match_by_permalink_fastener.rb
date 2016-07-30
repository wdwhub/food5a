class DfbVenueMatchByPermalinkFastener
  # attr_accessor :venue_id
  
  # def initialize(venue_id:)
  #   @venue_id = venue_id
  # end
  
  def title
    "i am the permalink fastner"
  end
  def fuse_with_venue(venue_id)
    # VenueFastener.new(attachment_class).fuse_with_venue
    venue                   = Venue.find(venue_id)
    venue_permalink         = venue.permalink
    dfb_eatery              = DfbEatery.find_by(permalink: venue_to_dfb_eatery_hash[venue_permalink])
    # reset related dfb_articles to nil
    venue.dfb_articles.each do |article|
      article.update(venue_id: nil)
    end
    # set current dfb_articles to be a child of venue
    dfb_eatery.dfb_articles.each do |article|
      article.update(venue_id: venue.id)
    end
    result =   {venue_id: venue_id, venue_articles: dfb_eatery.dfb_articles}
    
  end
  
  def venue_to_dfb_eatery_hash
    # key: venue, value: dfb_eatery
    {"the-wave-restaurant"            => "http://www.disneyfoodblog.com/the-wave/",
      "fresh-mediterranean-market"    => "http://www.disneyfoodblog.com/fresh-mediterranean-market/",
      "jiko-the-cooking-place"        => "http://www.disneyfoodblog.com/jiko/"
      # "chuck-wagon"        => "http://www.disneyfoodblog.com/chuck-wagon" uninidexed by dfb
      # "boma-flavors-of-africa"        => "http://www.disneyfoodblog.com/boma" uninidexed by dfb
      # "boatwrights"        => "www.disneyfoodblog.com/boatwrights/" uninidexed by dfb
    }
  end
end