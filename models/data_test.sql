MODEL (
    name sqlmesh_example.data_test,
    kind FULL,
    grain item_id,
    audits (assert_positive_order_ids),
  );

  SELECT
    item_id,
    COUNT(DISTINCT id) AS num_orders,
  FROM
    sqlmesh_example.seed_model
  GROUP BY item_id
  
--   Yeh code agar run krte hai toh error dega kyuki audit mai test lgaya hai ki id<2 condition lgayi hai 
--   raise audit_error_to_raise
-- sqlmesh.utils.errors.AuditError: Audit 'assert_positive_order_ids' for model 'sqlmesh_example.data_test' failed.
-- Got 1 results, expected 0.
-- But yeh snowflake pe output table create kr raha hai