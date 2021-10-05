CREATE OR REPLACE PROCEDURE transform_review_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.review_std CASCADE;

  -- insert into std table --
  INSERT INTO std.review_std
  SELECT 
  review_id,
  user_id,
  business_id,
  CAST(CAST (stars AS FLOAT) AS INT),
  CAST (date AS DATE),
  text,
  CAST (useful AS INT),
  CAST (funny AS INT),
  CAST (cool AS INT)
  FROM raw.review_raw;
  
END;$$;

CALL transform_review_std();
