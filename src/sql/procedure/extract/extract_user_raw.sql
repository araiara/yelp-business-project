CREATE OR REPLACE PROCEDURE extract_user_raw()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate temp and raw table --
  TRUNCATE TABLE temp.user_temp;
  TRUNCATE TABLE raw.user_raw;

  -- bulk import in temp table --
  COPY temp.user_temp
  FROM PROGRAM 'cmd /c "type F:\lf-data-engineering-internship\lf-final-project\data\user\yelp_academic_dataset_user.json"'
  CSV QUOTE e'\x01' DELIMITER e'\x02';

  -- insert into raw table --
  INSERT INTO raw.user_raw
  SELECT 
  user_temp_detail ->> 'user_id',
  user_temp_detail ->> 'name',
  user_temp_detail ->> 'review_count',
  user_temp_detail ->> 'yelping_since',
  user_temp_detail ->> 'friends',
  user_temp_detail ->> 'useful',
  user_temp_detail ->> 'funny',
  user_temp_detail ->> 'cool',
  user_temp_detail ->> 'fans',
  user_temp_detail ->> 'elite',
  user_temp_detail ->> 'average_stars',
  user_temp_detail ->> 'compliment_hot',
  user_temp_detail ->> 'compliment_more',
  user_temp_detail ->> 'compliment_profile',
  user_temp_detail ->> 'compliment_cute',
  user_temp_detail ->> 'compliment_list',
  user_temp_detail ->> 'compliment_note',
  user_temp_detail ->> 'compliment_plain',
  user_temp_detail ->> 'compliment_cool',
  user_temp_detail ->> 'compliment_funny',
  user_temp_detail ->> 'compliment_writer',
  user_temp_detail ->> 'compliment_photos'
  FROM temp.user_temp;
  
END;$$;

CALL extract_user_raw();
