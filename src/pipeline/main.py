import os
from src.utils.db import *

def extract_raw(connection):

    try:
        extract_procedure_dir_path = '../sql/procedure/extract/'
        extract_procedure_dir_files = os.listdir(extract_procedure_dir_path)
        table_names = []

        for file_name in extract_procedure_dir_files:
            if file_name in ['extract_business_raw.sql', 'extract_user_raw.sql', 'extract_review_raw.sql', 'extract_checkin_raw.sql', 'extract_tip_raw.sql']:
                continue
            table_name = file_name.replace('extract_', '').replace('.sql', '')
            table_names.append(table_name)

            with open(extract_procedure_dir_path+file_name) as extract_file:
                extract_query = "".join(extract_file.readlines())
                print("Extracting into {} table. Please wait...".format(table_name))
                execute_query(connection, extract_query)

    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully extracted tables.")

def main():
    connection = create_db_connection('yelp_business_db')
    extract_raw(connection)

    connection.close()

main()
