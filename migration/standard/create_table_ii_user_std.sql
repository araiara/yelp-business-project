CREATE TABLE IF NOT EXISTS std.user_std (
  user_id VARCHAR(22) PRIMARY KEY, 
  name VARCHAR(255) NOT NULL, 
  review_count INT NOT NULL, 
  yelping_since DATE NOT NULL, 
  friends TEXT[] NOT NULL,
  friends_count INT NOT NULL,  
  useful INT NOT NULL, 
  funny INT NOT NULL, 
  cool INT NOT NULL, 
  fans INT NOT NULL, 
  elite TEXT[] NOT NULL,
  elite_count INT NOT NULL,
  average_stars FLOAT NOT NULL
);
