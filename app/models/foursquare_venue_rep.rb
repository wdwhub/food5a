class FoursquareVenueRep < Representation
  
  def howard
    self.name
  end
  
  def place
    [self.address, self.crossStreet, self.postalCode, self.cc, self.city, self.state, self.country, 
      self.formattedAddress, self.lat, self.lng].join(" ")
  end
  
  def been_here
    "not needed currently"
  end
  
  def location
    self.location
  end
  
  def address
    "yes, address"
  end
  
end
