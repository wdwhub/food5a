FactoryGirl.define do
  factory :dfb_eatery do
    name "MyString"
    permalink "MyText"
    description "MyText"
    service "MyString"
    type_of_food "MyString"
    location "MyString"
    tables_in_wonderland "MyString"
    reviewlinks "MyText"
    important_info "MyText"
    you_might_also_like "MyString"
  end
  factory :remote_touring_plans_park_eatery_detail do
    name "Tony's Town Square Restaurant"
    permalink "tonys-town-square-restaurant"
    category_code "table_service"
    portion_size ""
    cost_code "moderate"
    cuisine "Italian"
    phone_number "407-939-3463"
    entree_range "Lunch $13.50-$20 (child $8.59)
    dinner $17-$30 (child $8.59)"
    when_to_go "Late lunch or early dinner"
    parking "Magic Kingdom lot"
    bar "None"
    wine_list "None"
    dress "Casual"
    awards ""
    breakfast_hours ""
    lunch_hours "Daily
    11:30 a.m. - 2:45 p.m."
    dinner_hours "Daily 5 p.m.-park closing"
    house_specialties "Lunch: sausage-and-pepperoni flatbreadspaghetti with\r\nmeatballs. Dinner: shrimp scampi chicken Parmigiana."
    counter_quality_rating ""
    counter_value_rating ""
    table_quality_rating 3.0
    table_value_rating 2.0
    overall_rating 2.5
    service_rating 4.0
    friendliness_rating 5.0
    thumbs_up 79
    adult_breakfast_menu_url ""
    adult_lunch_menu_url "http://allears.net/menu/menu_ttl.htm"
    adult_dinner_menu_url "http://allears.net/menu/menu_tts.htm"
    child_breakfast_menu_url ""
    child_lunch_menu_url "http://allears.net/menu/men_ttsk.htm"
    child_dinner_menu_url "http://allears.net/menu/men_ttsk.htm"
    requires_credit_card true
    requires_pre_payment false
    created_at "2010-08-26T23:28:58.000-04:00"
    updated_at "2015-09-28T06:04:23.000-04:00"
    extinct_on nil
    opened_on nil
    disney_permalink nil
    code "ORL107"
    short_name "Tony's Town Sq"
    accepts_tiw true
    accepts_reservations true
    kosher_available false
    location_details "in town square to the right after you go under the train station."
    operator_id 90002678
    operator_url "https://disneyworld.disney.go.com/dining/magic-kingdom/tonys-town-square-restaurant/"
    operator_type "restaurant"
  end
  factory :remote_touring_plans_park_eatery_summary do
    name "Park Eatery"
    sequence(:name) { |n| "Park Eatery#{n}"}
    sequence(:permalink) { |n| "park-eatery#{n}"}
  end
  factory :touring_plans_eatery do
    name "MyString"
    permalink "MyString"
    category_code "MyString"
    portion_size "MyString"
    cost_code "MyString"
    cuisine "MyString"
    phone_number "MyString"
    entree_range "MyString"
    when_to_go "MyString"
    parking "MyString"
    bar "MyString"
    wine_list "MyString"
    dress "MyString"
    awards "MyString"
    breakfast_hours "MyString"
    lunch_hours "MyString"
    dinner_hours "MyString"
    house_specialties "MyString"
    counter_quality_rating "MyString"
    counter_value_rating "MyString"
    table_quality_rating 1.5
    table_value_rating 1.5
    overall_rating 1.5
    service_rating 1.5
    friendliness_rating 1.5
    thumbs_up 1
    adult_breakfast_menu_url "MyString"
    adult_lunch_menu_url "MyString"
    adult_dinner_menu_url "MyString"
    child_breakfast_menu_url "MyString"
    child_lunch_menu_url "MyString"
    child_dinner_menu_url "MyString"
    requires_credit_card false
    requires_pre_payment false
    extinct_on "2016-07-20 16:43:54"
    opened_on "2016-07-20 16:43:54"
    disney_permalink "MyString"
    code "MyString"
    short_name "MyString"
    accepts_tiw false
    accepts_reservations false
    kosher_available false
    location_details "MyString"
    operator_id 1
    operator_url "MyText"
    operator_type "MyString"
  end
  factory :touring_plans_eatery_sync do
    
  end
  factory :district do
    name "MyString"
    permalink "MyString"
    is_park false
    credit "MyString"
    photo_url "MyString"
    flickr_search_term "MyString"
    published_at "2016-07-19 20:02:12"
    wdw_uri "MyString"
  end
end
