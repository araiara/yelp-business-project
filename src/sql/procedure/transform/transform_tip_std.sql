CREATE OR REPLACE PROCEDURE transform_tip_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.tip_std CASCADE;

  -- insert into std table --
  INSERT INTO std.tip_std (user_id, business_id, text, date, compliment_count)
  SELECT 
  user_id,
  business_id,
  text,
  CAST (date AS DATE),
  CAST (compliment_count AS INT)
  FROM raw.tip_raw;
  
END;$$;

CALL transform_tip_std();
