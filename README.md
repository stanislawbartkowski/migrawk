# migrawk

Several simple and useful bash/awk scripts to migrate tables and data from MS SQL Server t DB2.

## Files description

* ddl.awk Awk script to transform MS SQL tables export into DB2 friendly format
* insert.awk Awk script to transform MS SQL INSERT commands into DB2 friendly format
* fun.awk Several common Awk functions shared by ddl.awk and insert.awk
* proc.sh Bash script containing several common bash functions.
* templates
  * source.rc Environment variables containg several parameters.
  * run.sh Bash script to run ddl.awk 
  * runi.sh Bash scriptr to run insert.awk

## Functionality

### CREATE TABLE modification

Transforms MS SQL table definition into DB2 suported format.<br>




## Prerequisites

* DB2 instance and database up and running
* DB2 command line parameter should be installed

## Installation

Clone repository

> git clone https://github.com/stanislawbartkowski/migrawk.git<br>
> cd migrawk<br>
> cp templates/* .<br>

Modify source.rc, run.sh and run1.sh according to environment.


