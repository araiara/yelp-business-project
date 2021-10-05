CREATE OR REPLACE PROCEDURE transform_checkin_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.checkin_std CASCADE;

  -- insert into std table --
  INSERT INTO std.checkin_std (business_id, date)  
  SELECT business_id, cast(split_date as timestamp) 
  FROM raw.checkin_raw
  CROSS JOIN UNNEST(string_to_array(date, ',')) AS split_date;
    
END;$$;

CALL transform_checkin_std();
