import typing as t
from datetime import datetime

import pandas as pd
from snowflake.snowpark import Session
from sqlmesh.core.model.kind import ModelKindName
from sqlmesh import ExecutionContext, model

@model(
    "sqlmesh_example.python_empty",
    kind=dict(
        name=ModelKindName.FULL
    ),
    columns={
        "id": "int",
        "name": "text",
        "country": "text",
    },
)
def execute(
    context: ExecutionContext,
    start: datetime,
    end: datetime,
    execution_time: datetime,
    **kwargs: t.Any,
):
    df = context.snowpark.create_dataframe(
        [[1, "a", "usa"], [2, "b", "cad"]],
        schema=["id", "name", "country"]
    )
    
    filtered_df = df.filter(df["id"] > 3)
    
    if filtered_df.count() == 0:
        yield from ()
    
    return filtered_df

# Empty Dataframe mai error deta hai but official documentation mai likha hua hai ki empty dataframe mai work krta hai