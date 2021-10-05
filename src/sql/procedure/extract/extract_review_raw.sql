CREATE OR REPLACE PROCEDURE extract_review_raw()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate temp and raw table --
  TRUNCATE TABLE temp.review_temp;
  TRUNCATE TABLE raw.review_raw;

  -- bulk import in temp table --
  COPY temp.review_temp
  FROM PROGRAM 'cmd /c "type F:\lf-data-engineering-internship\lf-final-project\data\review\yelp_academic_dataset_review.json"'
  CSV QUOTE e'\x01' DELIMITER e'\x02';

  -- insert into raw table --
  INSERT INTO raw.review_raw
  SELECT 
  review_temp_detail ->> 'review_id',
  review_temp_detail ->> 'user_id',
  review_temp_detail ->> 'business_id',
  review_temp_detail ->> 'stars',
  review_temp_detail ->> 'date',
  review_temp_detail ->> 'text',
  review_temp_detail ->> 'useful',
  review_temp_detail ->> 'funny',
  review_temp_detail ->> 'cool'
  FROM temp.review_temp;
  
END;$$;

CALL extract_review_raw();
