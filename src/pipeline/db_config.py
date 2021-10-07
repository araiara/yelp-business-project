from src.utils.db import *

def db_config(connection, load_complete_history_flag, load_history_years):
    try:
        insert_dir_path = '../sql/procedure/system/'
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
    load_complete_history_flag = False
    load_history_years = 5

    connection = create_db_connection('yelp_business_db')
    db_config(connection, load_complete_history_flag, load_history_years)
    connection.close()

main()