CREATE TABLE IF NOT EXISTS std.tip_std (
  user_id VARCHAR(22) PRIMARY KEY, 
  business_id VARCHAR(22) NOT NULL, 
  text TEXT NOT NULL, 
  date DATE NOT NULL, 
  compliment_count INT NOT NULL,
  CONSTRAINT fk_tip_std_user_id
    FOREIGN KEY (user_id) 
    REFERENCES std.user_std(user_id),
  CONSTRAINT fk_tip_std_business_id
    FOREIGN KEY (business_id) 
    REFERENCES std.business_std(business_id)
);
