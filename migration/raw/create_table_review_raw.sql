CREATE TABLE IF NOT EXISTS raw.review_raw (
  review_id VARCHAR(255), 
  user_id VARCHAR(255), 
  business_id VARCHAR(255), 
  stars VARCHAR(255), 
  date VARCHAR(255), 
  text TEXT, 
  useful VARCHAR(255), 
  funny VARCHAR(255), 
  cool VARCHAR(255)
);
