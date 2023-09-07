## Handling supabase migration with migra tool

- https://supabase.com/blog/supabase-cli#migrations

# requirements

- read: https://supabase.com/blog/supabase-cli#migrations
- install: docker
- pull image: docker pull djrobstep/migra:latest
- add file github action: migrate.yaml

# steps supabase

- create two supabase projects  with sufix dev & prod
- download anon_key  & db_url from both projects

# flyway migration naming conventions

- V1__description.sql => V-version
- U1__description.sql => U- undo
- R1_description.sql => R-repeateable migration

# settup github actions

* Include local directory .github/workflows > migrate.yaml
* settup github password secret at "settings/secrets/actions"  need by migrate.yaml
  * -password="${{ secrets.SUPA_PRODUCTION_DB_PASSWORD}}"

# steps to generate migration files & sync production database

at integrated terminal set:

- alias migra="docker run djrobstep/migra:latestmigra"
- migra  [db_url_from] [db_url_target] --unsafe  > file_name.sql; this will generate the file named at migrations directory then push to development
- file_name.sql  must follow flyway naming convesion.
- example cmd :

  - migra postgresql://postgres:[YOUR-PASSWORD-PROD]@db.[ID_DATABASE_TARGET].supabase.co:5432/postgres postgresql://postgres:[YOUR-PASSWORD-DEV]@db.[ID_DATABASE_FROM ].supabase.co:5432/postgres --unsafe  > migrations/V1__getting_started_migration.sql
- make a PR  from dev to main  cherrypicking the migrations directory changes; this will trigger the migration job to sync prodcution database.

Keep in mind that data is not going to be migrated.


#### Explore New Migration Feature for Supabase

- https://www.youtube.com/watch?v=N0Wb85m3YMI&ab_channel=Supabase

#### Explore Local Development

- https://supabase.com/blog/supabase-local-dev
- https://www.youtube.com/watch?v=N0Wb85m3YMI&ab_channel=Supabase
