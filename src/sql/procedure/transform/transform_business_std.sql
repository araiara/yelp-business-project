CREATE OR REPLACE PROCEDURE transform_business_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.business_std CASCADE;

  -- insert into std table --
  INSERT INTO std.business_std
  SELECT 
  business_id,
  name,
  address,
  city,
  state,
  postal_code,
  CAST (latitude AS FLOAT),
  CAST (longitude AS FLOAT),
  CAST (stars AS FLOAT),
  CAST (review_count AS INT),
  CAST (is_open AS INT),
  categories,
  CAST(SPLIT_PART(hours ->> 'Monday', '-', 1) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Monday', '-', 2) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Tuesday', '-', 1) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Tuesday', '-', 2) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Wednesday', '-', 1) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Wednesday', '-', 2) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Thursday', '-', 1) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Thursday', '-', 2) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Friday', '-', 1) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Friday', '-', 2) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Saturday', '-', 1) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Saturday', '-', 2) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Sunday', '-', 1) AS TIME),
  CAST(SPLIT_PART(hours ->> 'Sunday', '-', 2) AS TIME),
  CASE 
    WHEN attributes ->> 'BikeParking' IS NULL
      THEN FALSE
    WHEN attributes ->> 'BikeParking' = 'None'
      THEN FALSE
  ELSE
    CAST(
      attributes ->> 'BikeParking'
      AS BOOLEAN)
  END,
  CASE 
    WHEN attributes ->> 'RestaurantsReservations' IS NULL
      THEN FALSE
    WHEN attributes ->> 'RestaurantsReservations' = 'None'
      THEN FALSE
  ELSE
    CAST(
      attributes ->> 'RestaurantsReservations'
      AS BOOLEAN)
  END,
  CASE 
    WHEN attributes ->> 'RestaurantsGoodForGroups' IS NULL
      THEN FALSE
    WHEN attributes ->> 'RestaurantsGoodForGroups' = 'None'
      THEN FALSE
  ELSE
    CAST(
      attributes ->> 'RestaurantsGoodForGroups'
      AS BOOLEAN)
  END,
  CASE 
    WHEN attributes ->> 'BusinessAcceptsCreditCards' IS NULL
      THEN FALSE
    WHEN attributes ->> 'BusinessAcceptsCreditCards' = 'None'
      THEN FALSE
  ELSE
    CAST(
      attributes ->> 'BusinessAcceptsCreditCards'
      AS BOOLEAN)
  END,
  CASE 
    WHEN attributes ->> 'RestaurantsTakeOut' IS NULL
      THEN FALSE
    WHEN attributes ->> 'RestaurantsTakeOut' = 'None'
      THEN FALSE
  ELSE
    CAST(
      attributes ->> 'RestaurantsTakeOut'
      AS BOOLEAN)
  END,
  CASE 
    WHEN attributes ->> 'RestaurantsDelivery' IS NULL
      THEN FALSE
    WHEN attributes ->> 'RestaurantsDelivery' = 'None'
      THEN FALSE
  ELSE
    CAST(
      attributes ->> 'RestaurantsDelivery'
      AS BOOLEAN)
  END,
  CASE 
    WHEN attributes ->> 'GoodForKids' IS NULL
      THEN FALSE
    WHEN attributes ->> 'GoodForKids' = 'None'
      THEN FALSE
  ELSE
    CAST(
      attributes ->> 'GoodForKids'
      AS BOOLEAN)
  END
  FROM raw.business_raw;  
END;$$;

CALL transform_business_std();
