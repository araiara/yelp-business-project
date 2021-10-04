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
  categories
  FROM raw.business_raw;
  
END;$$;

CALL transform_business_std();
