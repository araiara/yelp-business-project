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

def transform_std(connection):
    try:
        transform_procedure_dir_path = '../sql/procedure/transform/'
        transform_procedure_dir_files = os.listdir(transform_procedure_dir_path)
        table_names = []

        for file_name in transform_procedure_dir_files:
            if file_name in ['transform_business_std.sql']: #, 'transform_user_std.sql', 'transform_review_std.sql', 'transform_checkin_std.sql', 'transform_tip_std.sql']:
                continue
            table_name = file_name.replace('transform_', '').replace('.sql', '')
            table_names.append(table_name)

            with open(transform_procedure_dir_path+file_name) as transform_file:
                transform_query = "".join(transform_file.readlines())
                print("Transforming into {} table. Please wait...".format(table_name))
                execute_query(connection, transform_query)

    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully transformed tables.")

def main():
    connection = create_db_connection('yelp_business_db')
    extract_raw(connection)
    transform_std(connection)

    connection.close()

main()
