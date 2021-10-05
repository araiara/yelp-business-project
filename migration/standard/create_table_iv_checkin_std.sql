CREATE TABLE IF NOT EXISTS std.checkin_std (
  checkin_id SERIAL PRIMARY KEY,
  business_id VARCHAR(22) NOT NULL, 
  date TIMESTAMP NOT NULL,
  CONSTRAINT fk_checkin_std_business_id
    FOREIGN KEY (business_id) 
    REFERENCES std.business_std(business_id) 
);
