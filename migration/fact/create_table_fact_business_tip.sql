CREATE TABLE IF NOT EXISTS dwh.fact_business_tip (
  business_tip_id SERIAL PRIMARY KEY,
  user_id VARCHAR(22) NOT NULL, 
  business_id VARCHAR(22) NOT NULL, 
  text TEXT NOT NULL, 
  date DATE NOT NULL, 
  compliment_count INT NOT NULL,
  CONSTRAINT fk_fact_business_tip_user_id
    FOREIGN KEY (user_id) 
    REFERENCES dwh.dim_user(user_id),
  CONSTRAINT fk_fact_business_tip_business_id
    FOREIGN KEY (business_id) 
    REFERENCES dwh.dim_business(business_id)
);
