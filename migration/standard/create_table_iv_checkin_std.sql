CREATE TABLE IF NOT EXISTS std.checkin_std (
  business_id VARCHAR(22) PRIMARY KEY, 
  date TEXT NOT NULL,
  CONSTRAINT fk_checkin_std_business_id
    FOREIGN KEY (business_id) 
    REFERENCES std.business_std(business_id) 
);
