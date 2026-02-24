import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
import urllib.parse


base_path = os.path.dirname(__file__)
file_path = os.path.join(base_path,"..","data","raw","orders_data.xlsx")
file_path = os.path.abspath(file_path)

load_dotenv()  # .env 파일 읽기

# DB연결정보
user = "postgres"
password = urllib.parse.quote_plus(os.getenv('DB_PW'))
host = "127.0.0.1"
port = '5432'
database = 'ecommerce'

# 엔진 생성
engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{database}')

# 데이터 불러오기
data = pd.read_excel(file_path)

# raw_orders에 데이터 적재
data.to_sql(
    'raw_orders',
    con=engine,
    if_exists='append',
    index=False
)

'''
with engine.connect() as conn:
    result = conn.execute("SELECT current_database();")
    print(result.fetchone())
'''

print('데이터 적재 성공')