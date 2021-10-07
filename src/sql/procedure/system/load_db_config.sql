CREATE OR REPLACE PROCEDURE load_db_config()
LANGUAGE plpgsql
AS $$
BEGIN
  -- truncate table --
  TRUNCATE TABLE db_config;

  -- insert into table --
  INSERT INTO db_config VALUES (%s, %s);
  
END;$$;

CALL load_db_config();
