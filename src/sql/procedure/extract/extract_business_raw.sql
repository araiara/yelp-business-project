CREATE OR REPLACE PROCEDURE extract_business_raw()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate temp and raw table --
  TRUNCATE TABLE temp.business_temp;
  TRUNCATE TABLE raw.business_raw;

  -- bulk import in temp table --
  COPY temp.business_temp
  FROM PROGRAM 'cmd /c "type F:\lf-data-engineering-internship\lf-final-project\data\business\yelp_academic_dataset_business.json"'
  CSV QUOTE e'\x01' DELIMITER e'\x02';

  -- insert into raw table --
  INSERT INTO raw.business_raw
  SELECT   
  business_temp_detail ->> 'business_id',
  business_temp_detail ->> 'name',
  business_temp_detail ->> 'address',
  business_temp_detail ->> 'city',
  business_temp_detail ->> 'state',
  business_temp_detail ->> 'postal_code',
  business_temp_detail ->> 'latitude',
  business_temp_detail ->> 'longitude',
  business_temp_detail ->> 'stars',
  business_temp_detail ->> 'review_count',
  business_temp_detail ->> 'is_open',
  business_temp_detail -> 'attributes',
  business_temp_detail ->> 'categories',
  business_temp_detail -> 'hours'
  FROM temp.business_temp;
  
END;$$;

CALL extract_business_raw();
