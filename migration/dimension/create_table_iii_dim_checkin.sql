CREATE TABLE IF NOT EXISTS dwh.dim_checkin (
  checkin_id SERIAL PRIMARY KEY,
  business_id VARCHAR(22) NOT NULL, 
  date TIMESTAMP NOT NULL,
  CONSTRAINT fk_dim_checkin_business_id
    FOREIGN KEY (business_id) 
    REFERENCES dwh.dim_business(business_id) 
);
