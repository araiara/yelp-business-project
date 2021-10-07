CREATE TABLE IF NOT EXISTS dwh.dim_location (
  location_id SERIAL PRIMARY KEY,
  city VARCHAR(255),
  state VARCHAR(5)
);
