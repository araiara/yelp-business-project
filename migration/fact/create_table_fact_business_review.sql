CREATE TABLE IF NOT EXISTS dwh.fact_business_review (
  review_id VARCHAR(22), 
  user_id VARCHAR(22), 
  business_id VARCHAR(22), 
  stars INT NOT NULL, 
  date DATE NOT NULL, 
  text TEXT NOT NULL, 
  useful INT NOT NULL, 
  funny INT NOT NULL, 
  cool INT NOT NULL,
  CONSTRAINT pk_fact_business_review
    PRIMARY KEY (review_id, user_id, business_id),
  CONSTRAINT fk_fact_business_review_user_id
    FOREIGN KEY (user_id) 
    REFERENCES dwh.dim_user(user_id),
  CONSTRAINT fk_fact_business_review_business_id
    FOREIGN KEY (business_id) 
    REFERENCES dwh.dim_business(business_id)
);
