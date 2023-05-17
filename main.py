from sqlalchemy import create_engine, text
# import pandas as pd
import pyodbc
import pymssql

SERVER = '0.0.0.0:1433'
DATABASE = 'bank_db'
drivers = [item for item in pyodbc.drivers()]
DRIVER = drivers[-1]
print(f"{DRIVER=}")

USERNAME = 'sa'
PASSWORD = 'Sqlserver2023'
DATABASE_CONNECTION = f'mssql+pymssql://{USERNAME}:{PASSWORD}@{SERVER}/{DATABASE}'
engine = create_engine(DATABASE_CONNECTION)
conn = engine.connect()
result_set = conn.execute(text('SELECT * from account'))
for row in result_set:
    print(row)


