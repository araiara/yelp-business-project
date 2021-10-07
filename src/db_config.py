from utils.db import *

def db_config(connection, load_complete_history_flag, load_history_years):
    """
    Inserts the config values to the db_config table.
    params:
    param 'connection' database connection object
    type 'object'
    param 'load_complete_history_flag' flag that denotes load complete history
    type 'bool'
    param 'load_history_years' years of history data to insert from current date
    type 'int'
    """
    try:
        insert_dir_path = './sql/procedure/system/'
        insert_file_path = os.listdir(insert_dir_path)[0]
        insert_info = (load_complete_history_flag, load_history_years)

        with open(insert_dir_path+insert_file_path) as insert_file:
                insert_query = "".join(insert_file.readlines())
                execute_query(connection,insert_query, insert_info)
    except Exception as e:
        print("An error occurred: {}".format(e))

    else:
        print("Successfully inserted db config values.")

def main():
    """
    Main method.
    Configure the database.
    """
    load_complete_history_flag = False
    load_history_years = 5

    connection = create_db_connection('yelp_business_db')
    db_config(connection, load_complete_history_flag, load_history_years)
    connection.close()

main()