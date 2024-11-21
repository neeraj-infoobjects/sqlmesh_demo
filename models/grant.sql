MODEL (
    name sqlmesh_example.grant_model,
    kind INCREMENTAL_BY_TIME_RANGE (
      time_column event_date
    ),
    start '2020-01-01',
    cron '@daily',
    grain (id, event_date)
  );

USE ROLE accountadmin; -- This code requires USERADMIN privileges or higher

CREATE ROLE IF NOT EXISTS sqlmesh; -- Create role for permissions
CREATE DATABASE IF NOT EXISTS demo_db; -- Create database for SQLMesh to use (omit if database already exists)

GRANT USAGE ON WAREHOUSE compute_wh TO ROLE sqlmesh; -- Can use warehouse
GRANT USAGE ON DATABASE demo_db TO ROLE sqlmesh; -- Can use database

GRANT CREATE SCHEMA ON DATABASE demo_db TO ROLE sqlmesh; -- Can create SCHEMAs in database
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE demo_db TO ROLE sqlmesh; -- Can use schemas it creates
GRANT CREATE TABLE ON FUTURE SCHEMAS IN DATABASE demo_db TO ROLE sqlmesh; -- Can create TABLEs in schemas
GRANT CREATE VIEW ON FUTURE SCHEMAS IN DATABASE demo_db TO ROLE sqlmesh; -- Can create VIEWs in schemas
GRANT SELECT, INSERT, TRUNCATE, UPDATE, DELETE ON FUTURE TABLES IN DATABASE demo_db TO ROLE sqlmesh; -- Can SELECT and modify TABLEs in schemas
GRANT REFERENCES, SELECT ON FUTURE VIEWS IN DATABASE demo_db TO ROLE sqlmesh; -- Can SELECT and modify VIEWs in schemas

GRANT ROLE sqlmesh TO USER neeraj; -- Grant role to user
-- ALTER USER demo_user SET DEFAULT ROLE = sqlmesh; -- Make role user's default role

  SELECT
    id,
    item_id,
    event_date,
  FROM
    sqlmesh_example.seed_model
  WHERE
    event_date BETWEEN @start_date AND @end_date
  