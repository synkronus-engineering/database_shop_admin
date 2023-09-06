## Handing supabase migration with migra tool

- https://supabase.com/blog/supabase-cli#migrations

# requirements

- read: https://supabase.com/blog/supabase-cli#migrations
- install: docker
- pull image: docker pull djrobstep/migra
- add file github action: migrate.yaml

# steps supabase

- create two supabase projects  with sufix dev & prod
- download anon_key  & db_url from both projects

# steps migration with migra

at integrated terminal set:

- alias migra="docker run djrobstep/migra migra"
- migra  [db_url_from] [db_url_target] --unsafe  > file_name.sql
- file_name.sql  must follow flyway naming convesion.
- example cmd :

  - migra postgresql://postgres:[YOUR-PASSWORD-PROD]@db.[ID_DATABASE_TARGET].supabase.co:5432/postgres postgresql://postgres:[YOUR-PASSWORD-DEV]@db.[ID_DATABASE_FROM ].supabase.co:5432/postgres --unsafe  > migrations/V1__getting_started_migration.sql

# flyway migration naming conventions

- V1__description.sql => V-version
- U1__description.sql => U- undo
- R1_description.sql => R-repeateable migration

#### New Migration Feature for Supabase

- https://www.youtube.com/watch?v=N0Wb85m3YMI&ab_channel=Supabase

#### Local Development

- https://supabase.com/blog/supabase-local-dev
- https://www.youtube.com/watch?v=N0Wb85m3YMI&ab_channel=Supabase
