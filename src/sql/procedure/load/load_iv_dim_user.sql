CREATE OR REPLACE PROCEDURE load_dim_user()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate dim table --
  TRUNCATE TABLE dwh.dim_user CASCADE;  

  -- insert into dim table --
  INSERT INTO dwh.dim_user
  SELECT
  user_id,
  name,
  yelping_since,
  friends,
  friends_count,
  fans,
  elite,
  elite_count 
  FROM std.user_std;  

END;$$;

CALL load_dim_user();
