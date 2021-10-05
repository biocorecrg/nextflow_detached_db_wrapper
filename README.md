# nextflow_detached_db_wrapper

Wrapper scripts and documentation for launching database jobs to be used by Nextflow pipelines

So far it only has been tested with SGE/Univa queues.

Example command with several options:

```
nohup perl run_pipeline_mysql.pl -params "-with-dag -with-report -with-timeline" -conf params.config -nextflowver 21.04.03 -extra "-j y -l virtual_free=4G,h_rt=372800 -N MYSQL_container -m be -cwd -V -q myqueue" -script pipeline.nf &> log.mysql &
```

Only running MySQL instance. Useful for checking existing contents.
```
nohup perl run_pipeline_mysql.pl -conf params.config -mysqlonly -extra "-j y -l virtual_free=4G,h_rt=372800 -N MYSQL_container -m be -cwd -V -q myqueue"  &> log.mysqlonly &
```
