CREATE OR REPLACE PROCEDURE extract_checkin_raw()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate temp and raw table --
  TRUNCATE TABLE temp.checkin_temp;
  TRUNCATE TABLE raw.checkin_raw;

  -- bulk import in temp table --
  COPY temp.checkin_temp
  FROM PROGRAM 'cmd /c "type F:\lf-data-engineering-internship\lf-final-project\data\checkin\yelp_academic_dataset_checkin.json"'
  CSV QUOTE e'\x01' DELIMITER e'\x02';

  -- insert into raw table --
  INSERT INTO raw.checkin_raw
  SELECT 
  checkin_temp_detail ->> 'business_id',
  checkin_temp_detail ->> 'date'
  FROM temp.checkin_temp;
  
END;$$;

CALL extract_checkin_raw();
