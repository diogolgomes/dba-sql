/****** procedures “pesadas” com DMV’s
Autor: Diogo Lourenço Gomes
Data da Criação: 05/08/2020
Version: 1.0
Solicitante: Banpar
Info: Ordenação por quantidade de execuções
******/

SELECT TOP 100
    DB_NAME(qp.[dbid]) as [database],
    convert(char,  st.[text]),
    
    qs.last_execution_time,
    qs.execution_count,
 
    qs.total_elapsed_time / 1000 AS total_elapsed_time_ms,
    qs.last_elapsed_time / 1000 AS last_elapsed_time_ms,
    qs.min_elapsed_time / 1000 AS min_elapsed_time_ms,
    qs.max_elapsed_time / 1000 AS max_elapsed_time_ms,
    ((qs.total_elapsed_time / qs.execution_count) / 1000) AS avg_elapsed_time_ms,
 
    qs.total_worker_time / 1000 AS total_worker_time_ms,
    qs.last_worker_time / 1000 AS last_worker_time_ms,
    qs.min_worker_time / 1000 AS min_worker_time_ms,
    qs.max_worker_time / 1000 AS max_worker_time_ms,
    ((qs.total_worker_time / qs.execution_count) / 1000) AS avg_worker_time_ms,
   
    qs.total_physical_reads,
    qs.last_physical_reads,
    qs.min_physical_reads,
    qs.max_physical_reads,
   
    qs.total_logical_reads,
    qs.last_logical_reads,
    qs.min_logical_reads,
    qs.max_logical_reads,
   
    qs.total_logical_writes,
    qs.last_logical_writes,
    qs.min_logical_writes,
    qs.max_logical_writes
FROM
    sys.dm_exec_query_stats as qs
    CROSS APPLY sys.dm_exec_sql_text(qs.[sql_handle]) st
    OUTER APPLY sys.dm_exec_query_plan (qs.plan_handle) AS qp
ORDER BY
    qs.total_elapsed_time desc