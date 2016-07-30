class VenueFastener
  attr_accessor :venue_id, :fastener

  def initialize(fastener:,venue_id:)
    @venue_id = venue_id
    @fastener = fastener
  end
  
  def fuse_with_resource
    @fusion = fastener.fuse_with_venue(venue_id)
  end
end