import os
from sqlalchemy import create_engine, MetaData, Table

DIALECT = os.getenv('DIALECT', 'postgresql')
POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'localhost')
POSTGRES_PORT = os.getenv('POSTGRES_PORT', '5432')
POSTGRES_USER = os.getenv('POSTGRES_USER', 'admin')
POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'changeit')
POSTGRES_DB = os.getenv('POSTGRES_DB', 'test')
TEST_SCHEMA = os.getenv('TEST_SCHEMA', 'test')
TEST_TABLE = os.getenv('TEST_TABLE', 'ach_event')
URI = f'{DIALECT}://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}'

engine = create_engine(URI, connect_args=dict(sslmode="allow", keepalives_idle=200))


def main():
    meta = MetaData()
    t = Table(TEST_TABLE, meta, schema=TEST_SCHEMA, autoload=True, autoload_with=engine)
    print(t.c)


if __name__ == '__main__':
    main()
