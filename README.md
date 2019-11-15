# sqlalchemy-issue
Repo for debugging https://github.com/sqlalchemy/sqlalchemy/issues/4984

```shell
docker-compose up -d --build postgres
docker-compose build program
docker-compose run --rm program
```

The reflection works fine with `postgresql` dialect
so the issue may be with `sqlalchemy-redshift` when
using the `redshift+psycopg2` dialect.
