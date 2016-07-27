class DfbReviewParser 
  attr_accessor :parsable_document, :representable_hash, :default
  
  
  def initialize(parsable_document:, representable_hash: {})
    @parsable_document  = parsable_document
    @representable_hash = representable_hash
    @default            = DfbMissingVenue.new
  end
  
  def title
    "dfb review parser"
  end
  
  
  def parse_details
    representable_hash["description"]            = collect_description              || default.description
    representable_hash["service"]                = collect_service                  || default.service
    representable_hash["type_of_food"]           = collect_type_of_food             || default.type_of_food
    representable_hash["disney_dining_plan"]     = collect_disney_dining_plan       || default.disney_dining_plan
    representable_hash["location"]               = collect_location                 || default.location
    representable_hash["tables_in_wonderland"]   = collect_tables_in_wonderland     || default.tables_in_wonderland
    representable_hash["reviewlinks"]            = collect_reviews                  ||default.reviewlinks
    representable_hash[:important_info]          = collect_important_info           || default.important_info
    representable_hash[:disney_food_blog_posts]  = collect_blog_posts               || default.blog_posts
    representable_hash[:you_might_also_like]     = collect_you_might_also_like      || default.you_might_also_like
    result = representable_hash
  end
  
  def collect_description
    nil
  end
  
  def collect_service
    result              = default_strategy(:service)
    # "Counter Service"
  end
  
  def collect_type_of_food
    result              = default_strategy(:type_of_food)
    # "Snacks and drinks"
  end
  
  def collect_disney_dining_plan
    
    result              = default_strategy(:disney_dining_plan)
    # "Yes, Snack Items"
  end
  
  def collect_location
    result              = default_strategy(:location).to_s.titleize
    # "Magic Kingdom, Fantasyland"
  end

  def collect_tables_in_wonderland
    result              = default_strategy(:tables_in_wonderland)
    # "No"
  end

  def collect_reviews
    result              = review_links_strategy(key = "reviews")
    # nil
    # []
  end
  
  def collect_important_info
    nil
  end
  
  def collect_blog_posts
    nil
  end
  
  def collect_you_might_also_like
    result              = default_strategy(:you_might_also_like).to_s.titleize
    
    # "Aloha Isle, Sunshine Tree Terrace, Friar’s Nook"
  end

  def default_strategy(key)
    document_sections   = parsable_document.css('p').to_a.collect { |title| title.text.to_s}
    document_sections   = document_sections.collect { |ds| ds.downcase}
    search_term         = key.to_s.gsub(/_/," ")
    title_seq_no        = document_sections.find_index { |sec| /^#{search_term}:*/.match(sec)}.to_i
    return nil if title_seq_no.to_i < 1 # if search_term not found
    result              = document_sections[title_seq_no].split(/^#{search_term}:*/).last.to_s.strip
  end

  def review_links_strategy(key)
    document_sections_to_s    = parsable_document.css('p').to_a.collect { |title| title.text.to_s.downcase}
    search_term               = key.to_s.gsub(/_/," ")
    title_seq_no              = document_sections_to_s.find_index { |sec| /^#{search_term}:*/.match(sec)}.to_i
    review_section            = parsable_document.css('p')[title_seq_no]
    links                     = review_section.css('a')
    result                    = links.collect {|link| {"title" => link.text, "href" => link['href']}}
  end

  private
  
  def symbol_to_string(key)
    key.to_s
  end
  def page_keys
    keys = ["description", "service", "type_of_food", "disney_dining_plan",
            "location", "tables_in_wonderland", "reviewlinks",  
            "important_info", "disney_food_blog_posts", 
            "you_might_also_like"]
  end
end
