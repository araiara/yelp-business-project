CREATE OR REPLACE PROCEDURE load_fact_business_review()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate fact table --
  TRUNCATE TABLE dwh.fact_business_review CASCADE;  

  -- insert into fact table --
  INSERT INTO dwh.fact_business_review
  SELECT
  review_id,
  user_id,
  business_id,
  stars,
  date,
  text,
  useful,
  funny,
  cool
  FROM std.review_std;
  
END;$$;

CALL load_fact_business_review();
