import psycopg2 as pg2
from dotenv import load_dotenv
import os

load_dotenv() 

def create_db_connection(database):
    """
    Create database connection.
    params:
    param 'database' name of the database
    type 'string'
    """
    connection = None
    try:
        connection = pg2.connect(
            host = os.getenv('HOST'),
            user = os.getenv('USER'),
            password = os.getenv('PASSWORD'),
            port = os.getenv('PORT'),
            database = database
        )
    except Exception as e:
        print("An error occurred: {}".format(e))
    
    return connection

def execute_query(connection, query, value=None):   
    try:
        cursor = connection.cursor()
        cursor.execute(query, value)
        connection.commit()
    except Exception as e:
        print("An error occurred: {}".format(e))
    else:
        return cursor

# def truncate_table(connection, table_name):
#     try:
#         truncate_query = 'TRUNCATE TABLE {}'.format(table_name)
#         execute_query(connection, truncate_query)
#     except Exception as e:
#         print("An error occurred: {}".format(e)) 
