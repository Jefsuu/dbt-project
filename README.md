## A study dbt project

To reproduct the creation of this eviroment follow this step-by-step:

Inside docker folder run `creates_volumes.sh` to create the volume folders an set the needed permissions
> bash create_volumes.sh

then run the command below to build docker env and up the containers
> docker compose up --build -d

when the containers are up run the commands below inside the postgresql container:

    - first create prod_user, dev_user are already created
    > psql -h postgresql -U postgres -c "create user prod_user with password '1234' createdb;"

    - then create prod and dev databse with respectives users
    > psql -h postgresql -U prod_user -d postgres -c "create database \"adventureworks_prod\";"

    > psql -h postgresql -U dev_user -d postgres -c "create database \"adventureworks_dev\";"


    - when finished move to folder where script and data are, inside the container
    > cd /bitnami/postgresql/downloads/AdventureWorks

    - then execute the script to populate databases
    > psql -d adventureworks_prod < install.sql -U prod_user

    > psql -d adventureworks_dev < install.sql -U dev_user

Now you have postgres with prod and dev databases populated with adventureworks data

Now move to project folder `dbt-project/adventure_project`
And run dbt comands using the flag `--profiles-dir ../dbt_profile/`

Example: `dbt run --profiles-dir ../dbt_profile/`

Or set the env variable `DBT_PROFILES_DIR` on terminal
> export DBT_PROFILES_DIR=../dbt_profile/

