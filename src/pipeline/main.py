from src.utils.db import *
from extraction import extract_raw_from_temp, extract_raw
from transformation import transform_std
from load import load_into_dwh

def main():
    """
    Main method.
    Executes the ETL processes.
    """
    connection = create_db_connection('yelp_business_db')
    extract_raw_from_temp(connection)
    extract_raw(connection)
    transform_std(connection)
    load_into_dwh(connection)

    connection.close()

main()
