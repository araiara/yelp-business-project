CREATE OR REPLACE PROCEDURE load_dim_location()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate dim table --
  TRUNCATE TABLE dwh.dim_location CASCADE;

  -- insert into dim table --
  INSERT INTO dwh.dim_location (city, state)
  SELECT 
  distinct city,
  state  
  FROM std.business_std;  
END;$$;

CALL load_dim_location();
