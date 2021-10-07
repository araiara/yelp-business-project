import os, json
from src.utils.db import *

def extract_raw_from_temp(connection):
    """
    Extract the raw data into raw temp table.
    params:
    param 'connection' database connection object
    type 'object'
    """
    try:
        extract_procedure_dir_path = '../sql/procedure/extract/'
        extract_procedure_dir_files = os.listdir(extract_procedure_dir_path)

        for file_name in extract_procedure_dir_files:
            if file_name in ['extract_business_raw.sql']:
                continue
            table_name = file_name.replace('extract_', '').replace('.sql', '')

            with open(extract_procedure_dir_path+file_name) as extract_file:
                extract_query = "".join(extract_file.readlines())
                print("Extracting into {} table. Please wait...".format(table_name))
                execute_query(connection, extract_query)

    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully extracted tables.")

def extract_many(connection, insert_path, record_list):
    """
    Execute bulk insert into database table.
    params:
    param 'connection' database connection object
    type 'object'
    param 'insert_path' path of the insert query file
    type 'string'
    param 'record_list' records to insert into the table.
    type 'list'
    """
    try:
        cursor = connection.cursor()
        with open(insert_path) as insert_file:
            insert_query = "".join(insert_file.readlines())
            cursor.executemany(insert_query, record_list)
            connection.commit()
    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully extracted tables.")


def extract_raw(connection):
    """
    Extract the raw data into raw tables.
    params:
    param 'connection' database connection object
    type 'object'
    """
    try:
        data_dir_path = '../../data/'
        data_dir_name = os.listdir(data_dir_path) # ['business',...]

        extract_dir_path = '../sql/insert/raw/'
        extract_dir_files = os.listdir(extract_dir_path) # ['insert_checkin_raw.sql',...]

        for dir in data_dir_name:
            if dir in ['business']: continue
            file_name = os.listdir(data_dir_path+dir)
            insert_file_name = [extract_file_path for extract_file_path in extract_dir_files if ''.join(extract_file_path.split('_')[1]) == dir]

            file_path = data_dir_path+dir+'/'+file_name[0]
            insert_path = extract_dir_path+insert_file_name[0]
           
            with open(file_path, encoding="utf8") as file_data:
                batch = 0
                record_list = []

                for line in file_data:                   
                    record_list.append(json.loads(line))
                    batch += 1                   
                    
                    if batch == 20000: 
                        extract_many(connection, insert_path, record_list)
                        batch = 0
                        record_list = []
                        continue
                
                # for remaining records
                if len(record_list) > 0: extract_many(connection, insert_path, record_list)
   
    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully extracted tables.")
