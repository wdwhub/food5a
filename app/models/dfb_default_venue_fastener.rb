require 'fuzzy_match'

class DfbDefaultVenueFastener
  # attr_accessor :venue_id
  
  # def initialize(venue_id:)
  #   @venue_id = venue_id
  # end
  
  def fuse_with_venue(venue_id)
    # VenueFastener.new(attachment_class).fuse_with_venue
    fz                      = FuzzyMatch.new(DfbEatery.all, :read => :name)
    venue                   = Venue.find(venue_id)
    dfb_eatery              = fz.find(venue.name) #best name match
    dfb_eatery.dfb_articles.each do |article|
      article.update(venue_id: venue.id)
    end
    result = {venue_name: venue.name, venue_articles: venue.dfb_articles}
    
  end
  
end