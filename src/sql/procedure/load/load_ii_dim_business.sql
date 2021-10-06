CREATE OR REPLACE PROCEDURE load_dim_business()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate dim table --
  TRUNCATE TABLE dwh.dim_business CASCADE;

  -- insert into dim table --
  INSERT INTO dwh.dim_business
  SELECT 
  business_id, 
  name, 
  address, 
  location_id, 
  postal_code,
  latitude, 
  longitude, 
  is_open,  
  categories,
  hours_mon_start,
  hours_mon_end,
  hours_tues_start,
  hours_tues_end,
  hours_wed_start,
  hours_wed_end,
  hours_thurs_start,
  hours_thurs_end,
  hours_fri_start,
  hours_fri_end,
  hours_sat_start,
  hours_sat_end,
  hours_sun_start,
  hours_sun_end,
  is_bike_parking_available,
  is_restaurants_reservation_available,
  is_restaurant_good_for_groups,
  is_credit_cards_accepted,
  is_restaurant_takeout_available,
  is_restaurant_delivery_done,
  is_good_for_kids    
  FROM std.business_std bus
  JOIN dwh.dim_location loc 
    ON bus.city = loc.city
    AND bus.state = loc.state;  
END;$$;

CALL load_dim_business();

   



