from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from airflow.utils.task_group import TaskGroup
from airflow.utils.dates import days_ago

default_args = {
    'start_date': days_ago(1),
}

with DAG(
    dag_id='p5',
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
) as dag:

    with TaskGroup('task_1_group') as task_1_group:
        task_1 = BigQueryInsertJobOperator(
            task_id='task_1',
            configuration={
                "query": {
                    "query": "{% include 'undefined.sql' %}",
                    "useLegacySql": False,
                }
            },
        )