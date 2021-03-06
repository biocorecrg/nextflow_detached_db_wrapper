#!/usr/bin/env nextflow


/*
 * Copyright (c) 2019-2021, Centre for Genomic Regulation (CRG)
 *
 * MIT License
 */

/*
===========================================================
 @authors
 Toni Hermoso <toni.hermoso@crg.eu>
===========================================================
*/

version = '0.1'

nextflow.enable.dsl=2

/*
 * Input parameters:
*/

params.help            = false
params.resume          = false
params.dbhost          = "127.0.0.1"

log.info """
Nextflow Example Database Wrapper ~  version ${version}

"""

if (params.help) {
    log.info """This is the pipeline"""
    log.info """Please write some description here\n"""
    exit 1
}

if (params.resume) exit 1, "Are you making the classical --resume typo? Be careful!!!! ;)"

// Notice. If no MySQL, PASA CANNOT work
boolean mysql = false
if(params.dbengine == "mysql") {
	mysql = true
}

// Full Workflow
workflow {

  out = channel
    .of('Hello','world')
    .map( it -> tuple(it) )
    .sqlInsert( into: 'test', columns: 'id', db: 'dbtest',
    setup: 'CREATE TABLE test (id varchar(20))' )


   // query_select = "SELECT id FROM test"
   // channel.sql.fromQuery(query_select, db: 'dbtest').view()

}

// On finishing
workflow.onComplete {

 println ( workflow.success ? "Done!\n" : "Oops .. something went wrong" )
 if ( mysql ) {

   def procfile = new File( params.mysqllog+"/PROCESS" )
   procfile.delete()
 }

}

workflow.onError {

 println( "Something went wrong" )

 if ( mysql ) {

   def procfile = new File( params.mysqllog+"/PROCESS" )
   procfile.delete()
 }

}
