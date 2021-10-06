import os
from src.utils.db import *

def load_into_dwh(connection):
    """
    Load the standard data tables into data warehouse.
    params:
    param 'connection' database connection object
    type 'object'
    """
    try:
        load_procedure_dir_path = '../sql/procedure/load/'
        load_procedure_dir_files = os.listdir(load_procedure_dir_path)

        for file_name in sorted(load_procedure_dir_files):
            if file_name in ['load_i_dim_location.sql', 'load_ii_dim_business.sql', 'load_iii_dim_checkin.sql', 'load_iv_dim_user.sql', 'load_v_fact_business_review.sql']:
                continue
            table_name = '_'.join(file_name.split('_')[2:]).replace('.sql', '') 
                      
            with open(load_procedure_dir_path+file_name) as load_file:
                load_query = "".join(load_file.readlines())
                print("Loading into {} table. Please wait...".format(table_name))
                execute_query(connection, load_query)

    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully loaded tables.")
        