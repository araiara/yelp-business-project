CREATE OR REPLACE PROCEDURE extract_tip_raw()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate temp and raw table --
  TRUNCATE TABLE temp.tip_temp;
  TRUNCATE TABLE raw.tip_raw;

  -- bulk import in temp table --
  COPY temp.tip_temp
  FROM PROGRAM 'cmd /c "type F:\lf-data-engineering-internship\lf-final-project\data\tip\yelp_academic_dataset_tip.json"'
  CSV QUOTE e'\x01' DELIMITER e'\x02';

  -- insert into raw table --
  INSERT INTO raw.tip_raw
  SELECT 
  BTRIM(CAST(tip_temp_detail -> 'user_id' AS TEXT), '"'),
  BTRIM(CAST(tip_temp_detail -> 'business_id' AS TEXT), '"'),
  BTRIM(CAST(tip_temp_detail -> 'text' AS TEXT), '"'),
  BTRIM(CAST(tip_temp_detail -> 'date' AS TEXT), '"'),
  tip_temp_detail -> 'compliment_count'
  FROM temp.tip_temp;
  
END;$$;

CALL extract_tip_raw();
