class DfbReviewParser 
  attr_accessor :parsable_document, :representable_hash
  
  
  def initialize(parsable_document:, representable_hash: {})
    @parsable_document = parsable_document
    @representable_hash = representable_hash
  end
  
  def title
    "dfb review parser"
  end
  
  
  def parse_details
    default = DfbMissingVenue.new
    representable_hash[:description] = collect_description                        || default.description
    representable_hash[:service] = collect_service                                || default.service
    representable_hash[:type_of_food] = collect_type_of_food                      || default.type_of_food
    representable_hash[:disney_dining_plan] = collect_disney_dining_plan          || default.disney_dining_plan
    representable_hash[:location] = collect_location                              || default.location
    representable_hash[:tables_in_wonderland] = collect_tables_in_wonderland      || default.tables_in_wonderland
    representable_hash[:reviews] = collect_reviews                                || default.reviews
    representable_hash[:important_info] = collect_important_info                  || default.important_info
    representable_hash[:disney_food_blog_posts] = collect_disney_food_blog_posts  || default.disney_food_blog_posts
    representable_hash[:you_might_also_like] = collect_you_might_also_like        || default.you_might_also_like
    result = representable_hash
  end
  
  def collect_description
    "Once known as Enchanted Grove, the Cheshire Cafe in the Magic Kingdom’s Fantasyland was rethemed and renamed in fall 2011 to better match the teacups right next door. The whimsical location’s menu remains much the same, with cereal, muffins and fruit available, along with yummy slushes, strawberry punch, and other refreshing beverages."
  end
  
  def collect_service
    "Counter Service"
  end
  
  def collect_type_of_food
    "Snacks and drinks"
  end
  
  def collect_disney_dining_plan
    "Yes, Snack Items"
  end
  
  def collect_location
    "Magic Kingdom, Fantasyland"
  end

  def collect_tables_in_wonderland
    "No"
  end

  def collect_reviews
    "Disney Food Blog Review: NEW Gourmet Cake Cups at Magic Kingdom’s Cheshire Cafe
    Disney Food Blog Review: White Chocolate Rabbit and Queen of Hearts Gourmet Cake Cups at Cheshire Cafe!
    Disney Food Blog Review: Cheese Danish at Magic Kingdom’s Cheshire Cafe"
  end
  
  def collect_important_info
    "Located directly across from the Mad Tea Party on the eastern side of Fantasyland, this is a great place to grab a treat before waiting to twirl around in the teacups. Or, on second thought, maybe you should wait until after…."
  end
  
  def collect_disney_food_blog_posts
    "Review: Cheese Danish at Magic Kingdom’s Cheshire Cafe
    Tip from the DFB Guide: Budgeting For Disney Snacks!
    “The Best Thing I Ever Ate in Disney!” Snacks (Vol. II)
    Disney Food Post Round-Up: June 8, 2014
    Disney Food Post Round-Up: March 16, 2014
    Review: White Chocolate Rabbit and Queen of Hearts Gourmet Cake Cups at Cheshire Cafe!
    Seven Must-Eat Disney Treats for 2014!
    Our Favorite, Must-Eat Disney Cakes!
    6 New Things You’ve Gotta Try in Disney World!
    Disney Food Post Round-Up: September 29, 2013"
  end
  
  def collect_you_might_also_like
    "Aloha Isle, Sunshine Tree Terrace, Friar’s Nook"
  end
  
  private
  
  def page_keys
    keys = [:description, :service, :type_of_food, :disney_dining_plan,
            :location, :tables_in_wonderland, :reviews,  
            :important_info, :disney_food_blog_posts, 
            :you_might_also_like]
  end
end
