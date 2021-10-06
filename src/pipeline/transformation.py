import os
from src.utils.db import *

def transform_std(connection):
    """
    Transform the raw data tables into standard data tables.
    params:
    param 'connection' database connection object
    type 'object'
    """  
    try:
        transform_procedure_dir_path = '../sql/procedure/transform/'
        transform_procedure_dir_files = os.listdir(transform_procedure_dir_path)

        with open('../sql/query/retrieve_db_config.sql') as config_file:
            config_query = "".join(config_file.readlines())
            cursor = execute_query(connection, config_query)
            config = cursor.fetchone()

        for file_name in sorted(transform_procedure_dir_files):
            if file_name in ['transform_i_business_std.sql', 'transform_ii_user_std.sql', 'transform_iii_review_std.sql', 'transform_iv_checkin_std.sql', 'transform_v_tip_std.sql']:
                continue
            table_name = '_'.join(file_name.split('_')[2:]).replace('.sql', '')            

            with open(transform_procedure_dir_path+file_name) as transform_file:
                transform_query = "".join(transform_file.readlines())
                print("Transforming into {} table. Please wait...".format(table_name))
                execute_query(connection, transform_query, config)

    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully transformed tables.")
        