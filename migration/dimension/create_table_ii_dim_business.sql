CREATE TABLE IF NOT EXISTS dwh.dim_business (
  business_id VARCHAR(22) PRIMARY KEY, 
  name VARCHAR(255) NOT NULL, 
  address VARCHAR(255) NOT NULL, 
  location_id INT NOT NULL,
  postal_code VARCHAR(255) NOT NULL,
  latitude FLOAT NOT NULL, 
  longitude FLOAT NOT NULL,  
  is_open INT NOT NULL,  
  categories TEXT[],
  hours_mon_start TIME,
  hours_mon_end TIME,
  hours_tues_start TIME,
  hours_tues_end TIME,
  hours_wed_start TIME,
  hours_wed_end TIME,
  hours_thurs_start TIME,
  hours_thurs_end TIME,
  hours_fri_start TIME,
  hours_fri_end TIME,
  hours_sat_start TIME,
  hours_sat_end TIME,
  hours_sun_start TIME,
  hours_sun_end TIME,
  is_bike_parking_available BOOLEAN NOT NULL,
  is_restaurants_reservation_available BOOLEAN NOT NULL,
  is_restaurant_good_for_groups BOOLEAN NOT NULL,
  is_credit_cards_accepted BOOLEAN NOT NULL,
  is_restaurant_takeout_available BOOLEAN NOT NULL,
  is_restaurant_delivery_done BOOLEAN NOT NULL,
  is_good_for_kids BOOLEAN NOT NULL,
  CONSTRAINT fk_dim_business_location_id
    FOREIGN KEY (location_id)
    REFERENCES dwh.dim_location(location_id)
);
