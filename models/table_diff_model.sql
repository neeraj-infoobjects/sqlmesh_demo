MODEL(
    name sqlmesh_example.table_diff_model,
    kind FULL,
    grain item_id,
);

select * from sqlmesh_example.seed_model;