CREATE OR REPLACE PROCEDURE transform_tip_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.tip_std CASCADE;

  IF %s IS TRUE 
  THEN
    -- insert into std table --
    INSERT INTO std.tip_std (user_id, business_id, text, date, compliment_count)
    SELECT 
    user_id,
    business_id,
    text,
    CAST (date AS DATE),
    CAST (compliment_count AS INT)
    FROM raw.tip_raw;
  ELSE
    INSERT INTO std.tip_std (user_id, business_id, text, date, compliment_count)
    SELECT 
    user_id,
    business_id,
    text,
    CAST (date AS DATE),
    CAST (compliment_count AS INT)
    FROM raw.tip_raw
    WHERE DATE_PART('year', current_date) - DATE_PART('year', CAST(date AS DATE)) <= %s;
  END IF;
  
END;$$;

CALL transform_tip_std();
