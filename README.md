# sqlalchemy-issue
Repo for debugging https://github.com/sqlalchemy/sqlalchemy/issues/4984

```shell
docker-compose up -d --build postgres
docker-compose build program
docker-compose run --rm program
```

To reproduce the error change the following
environment variables in the `docker-compose.yaml`
to point to a redshift cluster.
```bash
POSTGRES_HOST: <redshift host>
POSTGRES_PORT: 5439
POSTGRES_USER: <redshift user>
POSTGRES_PASSWORD: <redshift password>
POSTGRES_DB: <redshift database>
DIALECT: redshift+psycopg2
TEST_SCHEMA: <redshift schema>
TEST_TABLE: <redshift table>
```

Stack trace when trying to reflect a table.
```
$ dc run --rm program
Traceback (most recent call last):
  File "main.py", line 23, in <module>
    main()
  File "main.py", line 18, in main
    t = Table(TEST_TABLE, meta, schema=TEST_SCHEMA, autoload=True, autoload_with=engine)
  File "<string>", line 2, in __new__
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/util/deprecations.py", line 128, in warned
    return fn(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/sql/schema.py", line 506, in __new__
    metadata._remove_table(name, schema)
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.reraise(exc_type, exc_value, exc_tb)
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/util/compat.py", line 153, in reraise
    raise value
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/sql/schema.py", line 501, in __new__
    table._init(name, metadata, *args, **kw)
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/sql/schema.py", line 595, in _init
    resolve_fks=resolve_fks,
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/sql/schema.py", line 619, in _autoload
    _extend_on=_extend_on,
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/engine/base.py", line 2163, in run_callable
    return conn.run_callable(callable_, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/engine/base.py", line 1615, in run_callable
    return callable_(self, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/engine/default.py", line 460, in reflecttable
    table, include_columns, exclude_columns, resolve_fks, **opts
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/engine/reflection.py", line 642, in reflecttable
    table_name, schema, **table.dialect_kwargs
    self.bind, table_name, schema, info_cache=self.info_cache, **kw
  File "<string>", line 2, in get_columns
  File "/usr/local/lib/python3.7/site-packages/sqlalchemy/engine/reflection.py", line 50, in cache
    ret = info_cache.get(key)
TypeError: unhashable type: 'list'
```
The reflection works fine with `postgresql` dialect
so the issue may be with `sqlalchemy-redshift` when
using the `redshift+psycopg2` dialect.
