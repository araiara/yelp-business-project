CREATE OR REPLACE PROCEDURE transform_checkin_std()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate std table --
  TRUNCATE TABLE std.checkin_std CASCADE;  

  IF %s IS TRUE 
  THEN
    -- insert into std table --
    INSERT INTO std.checkin_std (business_id, date)  
    SELECT business_id, cast(split_date as timestamp) 
    FROM raw.checkin_raw
    CROSS JOIN UNNEST(string_to_array(date, ',')) AS split_date;
  ELSE
    INSERT INTO std.checkin_std (business_id, date) 
    SELECT business_id, cast(split_date as timestamp) 
    FROM raw.checkin_raw
    CROSS JOIN UNNEST(string_to_array(date, ',')) AS split_date
    WHERE DATE_PART('year', current_date) - DATE_PART('year', CAST(split_date AS DATE)) <= %s;
  END IF;
    
END;$$;

CALL transform_checkin_std();
