MODEL(
    name sqlmesh_example.custom_test,
    kind FULL,
    audits (
    not_null(columns := (id))
  )
);

Select id,item_id from sqlmesh_example.seed_model;
-- AZAM se confirm krle
-- Summary of differences against `prod`:
-- Models:
-- └── Directly Modified:
--     └── SQLMESH_EXAMPLE.CUSTOM_TEST
-- --- 

-- +++ 

-- @@ -6,5 +6,6 @@

--    audits (NOT_NULL('columns' = (id, item_id)))
--  )
--  SELECT
-- -  *
-- +  id,
-- +  item_id
--  FROM sqlmesh_example.seed_model
-- Directly Modified: SQLMESH_EXAMPLE.CUSTOM_TEST (Breaking)
-- Models needing backfill (missing dates):
-- └── SQLMESH_EXAMPLE.CUSTOM_TEST: 2024-11-20 - 2024-11-20

-- Error: Failed processing SnapshotId<"NB_DEMOS"."SQLMESH_EXAMPLE"."SEED_MODEL": 1591756957>. 
-- 100038 (22018): 01b8859f-3201-5499-000a-efc2000472c2: Numeric value '' is not recognized

-- kyuki maine seed data mai value nahi di uske baad seedmode aur iss model dpodno ko run kiya