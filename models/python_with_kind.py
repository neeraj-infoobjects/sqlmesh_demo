import typing as t
from datetime import datetime

import pandas as pd
from snowflake.snowpark.dataframe import DataFrame
from sqlmesh.core.model.kind import ModelKindName
from sqlmesh import ExecutionContext, model

@model(
    "sqlmesh_example.python_with_kind",
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
) -> DataFrame:
    # returns the snowpark DataFrame directly, so no data is computed locally
    df = context.snowpark.create_dataframe([[1, "a", "usa"], [2, "b", "cad"]], schema=["id", "name", "country"])
    df = df.filter(df.id > 1)
    return df
