CREATE TABLE IF NOT EXISTS dwh.dim_user (
  user_id VARCHAR(22) PRIMARY KEY, 
  name VARCHAR(255) NOT NULL,  
  yelp_user_since DATE NOT NULL, 
  friends TEXT[] NOT NULL,
  friends_count INT NOT NULL,   
  fans INT NOT NULL, 
  elite TEXT[] NOT NULL,
  elite_count INT NOT NULL
);
