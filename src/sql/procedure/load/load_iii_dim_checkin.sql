CREATE OR REPLACE PROCEDURE load_dim_checkin()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate dim table --
  TRUNCATE TABLE dwh.dim_checkin CASCADE;  

  -- insert into dim table --
  INSERT INTO dwh.dim_checkin (business_id, date)  
  SELECT 
  business_id, 
  date
  FROM std.checkin_std;    
END;$$;

CALL load_dim_checkin();
