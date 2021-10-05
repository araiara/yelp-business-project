import os
from src.utils.db import *

def create_schema(connection):
    create_schema_names = ['temp', 'raw', 'std']
    # schema_dir_file = os.listdir('../../schema')

    check_schema_query = '''
        SELECT schema_name 
        FROM information_schema.schemata;
    '''  

    try: 
        cursor = execute_query(connection, check_schema_query)
        exist_schema_list = cursor.fetchall()

        for schema_name in create_schema_names:
            if (schema_name,) not in exist_schema_list:
                create_query = 'CREATE SCHEMA IF NOT EXISTS {};'.format(schema_name)                
                cursor = execute_query(connection, create_query) 
    except Exception as e:
        print("An error occurred: {}".format(e)) 

def create_temp_table(connection):
    create_temp_table_names = ['business_temp', 'user_temp', 'review_temp', 'checkin_temp', 'tip_temp']

    check_table_query = '''
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema='temp'
          AND table_type='BASE TABLE';
    '''  

    try: 
        cursor = execute_query(connection, check_table_query)
        exist_table_list = cursor.fetchall()

        for table_name in create_temp_table_names:
            if (table_name,) not in exist_table_list:
                create_query = '''
                    CREATE TABLE IF NOT EXISTS temp.{} (
                    {} JSONB
                );                
                '''.format(table_name, table_name+'_detail')                
                cursor = execute_query(connection, create_query) 
                print("Successfully created {} table.".format(table_name))
    except Exception as e:
        print("An error occurred: {}".format(e))

def create_raw_table(connection):
    check_table_query = '''
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema='raw'
          AND table_type='BASE TABLE';
    '''  

    try: 
        cursor = execute_query(connection, check_table_query)
        exist_table_list = cursor.fetchall()
        raw_dir_path = '../../migration/raw/'
        raw_dir_file = os.listdir(raw_dir_path)

        for file_name in raw_dir_file:
            if (file_name.replace('create_table_', '').replace('.sql', ''),) not in exist_table_list:
                with open(raw_dir_path+file_name) as create_file:
                    create_query = "".join(create_file.readlines())
                    cursor = execute_query(connection, create_query)
                    print("Successfully created {} table.".format(file_name.replace('create_table_', '').replace('.sql', '')))

    except Exception as e:
        print("An error occurred: {}".format(e))

def create_std_table(connection):
    check_table_query = '''
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema='std'
          AND table_type='BASE TABLE';
    '''  

    try: 
        cursor = execute_query(connection, check_table_query)
        exist_table_list = cursor.fetchall()
        std_dir_path = '../../migration/standard/'
        std_dir_file = os.listdir(std_dir_path)

        for file_name in sorted(std_dir_file):
            if ('_'.join(file_name.split('_')[3:]).replace('.sql', ''), ) not in exist_table_list:                
                with open(std_dir_path+file_name) as create_file:
                    create_query = "".join(create_file.readlines())
                    cursor = execute_query(connection, create_query)
                    print("Successfully created {} table.".format(file_name.replace('create_table_', '').replace('.sql', '')))

    except Exception as e:
        print("An error occurred: {}".format(e))
 
def main():
    connection = create_db_connection('yelp_business_db')
    create_schema(connection)
    create_temp_table(connection)
    create_raw_table(connection)
    create_std_table(connection)

    connection.close()

main()
