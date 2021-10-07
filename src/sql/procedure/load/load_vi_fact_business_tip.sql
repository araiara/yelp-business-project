CREATE OR REPLACE PROCEDURE load_fact_business_tip()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate fact table --
  TRUNCATE TABLE dwh.fact_business_tip CASCADE;  

  -- insert into fact table --
  INSERT INTO dwh.fact_business_tip (user_id, business_id, text, date, compliment_count)
  SELECT
  user_id, 
  business_id, 
  text, 
  date, 
  compliment_count
  FROM std.tip_std;
  
END;$$;

CALL load_fact_business_tip();
