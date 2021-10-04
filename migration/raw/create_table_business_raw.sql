CREATE TABLE IF NOT EXISTS raw.business_raw (
  business_id VARCHAR(255), 
  name VARCHAR(255), 
  address VARCHAR(255), 
  city VARCHAR(255), 
  state VARCHAR(255), 
  postal_code VARCHAR(255),
  latitude VARCHAR(255), 
  longitude VARCHAR(255), 
  stars VARCHAR(255), 
  review_count VARCHAR(255), 
  is_open VARCHAR(255), 
  attributes JSONB, 
  categories TEXT, 
  hours JSONB
);
