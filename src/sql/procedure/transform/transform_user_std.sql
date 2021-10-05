CREATE OR REPLACE PROCEDURE transform_user_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.user_std CASCADE;

  -- insert into std table --
  INSERT INTO std.user_std
  SELECT 
  user_id,
  name,
  CAST (review_count AS INT),
  CAST (yelping_since AS DATE),
  friends,
  CAST (useful AS INT),
  CAST (funny AS INT),
  CAST (cool AS INT),
  CAST (fans AS INT),
  elite,
  CAST(average_stars AS FLOAT)
  FROM raw.user_raw;
  
END;$$;

CALL transform_user_std();
