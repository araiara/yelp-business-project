CREATE TABLE IF NOT EXISTS std.business_std (
  business_id VARCHAR(22) PRIMARY KEY, 
  name VARCHAR(255) NOT NULL, 
  address VARCHAR(255) NOT NULL, 
  city VARCHAR(255) NOT NULL, 
  state VARCHAR(5) NOT NULL, 
  postal_code VARCHAR(255) NOT NULL,
  latitude FLOAT NOT NULL, 
  longitude FLOAT NOT NULL, 
  stars FLOAT NOT NULL, 
  review_count INT NOT NULL, 
  is_open INT NOT NULL,  
  categories TEXT NOT NULL  
);
