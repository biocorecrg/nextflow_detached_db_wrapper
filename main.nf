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

dbhost = null

// Getting contents of file
if ( mysql ) {
 dbhost = "127.0.0.1" // Default value

 if ( new File(  params.mysqllog+"/DBHOST" ).exists() ) {
  dbhost = new File(  params.mysqllog+"/DBHOST" ).text.trim()
 }
}

// Full Workflow
workflow {

  // TODO: Fill an example process here using MySQL
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
