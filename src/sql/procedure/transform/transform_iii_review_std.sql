CREATE OR REPLACE PROCEDURE transform_review_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.review_std CASCADE;

  IF %s IS TRUE 
  THEN
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
  ELSE
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
    FROM raw.review_raw
    WHERE DATE_PART('year', current_date) - DATE_PART('year', CAST(date AS DATE)) <= %s;
  END IF;
  
END;$$;

CALL transform_review_std();
