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

### CREATE TABLE modification, dll.awk

https://github.com/stanislawbartkowski/migrawk/blob/master/ddl.awk

Transforms MS SQL table definition into DB2 suported format.<br>
Example, source MSSQL table<br>
```sql
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Codigos](
	[First_name] [nvarchar](max) NOT NULL,
	[Last_name] [nvarchar](max) NOT NULL,
	[Number_of_registrations] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
```
DB2 table after tranformation<br>
```
CREATE TABLE Codigos (
	First_name nvarchar(max) NOT NULL,
	Last_name nvarchar(max) NOT NULL,
	Number_of_registrations int NOT NULL,
	Comment nvarchar(max) NULL
);
```
Tranformation:
* Removes \[dbo\] and all \[ and \] characters
* Replaces (max) with (6000)
* Removes all lines outside CREATE TABLE definition
* Removes tablespace declaration 

### INSERT clause, insert.awk

https://github.com/stanislawbartkowski/migrawk/blob/master/insert.awk

Transforms sequence of INSERT in MS SQL format into DB2 supported syntax.
Sample MS SQL input.
```SQL
INSERT [dbo].[Codigos] ([First_name], [Last_name], [Number_of_registrations], [Comment]) VALUES (N'Velocidad', N'Velocidad', 1, N'dam/h')
INSERT [dbo].[Codigos] ([First_name], [Last_name], [Number_of_registrations], [Comment]) VALUES (N'Freno emergencia por HM', N'Freno Emerg. HM', 1,N'')
```
DB2 after tranformation.
```SQL
INSERT INTO Codigos (First_name, Last_name, Number_of_registrations, Comment) VALUES (N'Velocidad', N'Velocidad', 1, N'dam/h');
INSERT INTO Codigos (First_name, Last_name, Number_of_registrations, Comment) VALUES (N'Freno emergencia por HM', N'Freno Emerg. HM', 1,N'');
```

Transformation:
* Removes \[dbo\] and all \[ and \] characters
* Inserts INTO keyword
* Add semicolon (;) at the end
* Removes all stuff outside INSERT command

## Prerequisites

* DB2 instance and database up and running
* DB2 command line parameter should be installed
* Target DB2 database should be catalogued

## Installation

Clone repository

> git clone https://github.com/stanislawbartkowski/migrawk.git<br>
> cd migrawk<br>
> cp templates/* .<br>

Modify source.rc, run.sh and run1.sh adjusting then to your needs.

## Configuration, source.rc

https://github.com/stanislawbartkowski/migrawk/blob/master/templates/source.rc

| Parameter  | Description | Sample value
| ------------- | ------------- | -------- |
| DATABASE  | DB2 database name  | DB
| USER  | DB user name  | db2inst1
| PASSWORD | DB2 user password | db2inst1
| SCRIPTFILE | MS SQL script containing CREATE TABLE command, used by run.sh script | 
| DIRFILE | Directory containg MSSQL scripts with INSERT command, used by runi.sh |
| LIST | List of files in DRIFILE separated by comma (,) user by runi.sh

DATABASE, USER and PASSWORD command is used to set up DB2 connection.<br>
> db2 connect to $DATABASE user $USER using $PASSWORD<br>

## Execution

### run.sh
https://github.com/stanislawbartkowski/migrawk/blob/master/templates/run.sh

run.sh script is the wrapper around awk ddl.awk file. The script reads $SCRIPTFILE, transforms using ddl.awk and load the result directly to DB2 database.

### runi.sh
https://github.com/stanislawbartkowski/migrawk/blob/master/templates/runi.sh

runi.sh script is the wrapper around insert.awl file. The script reads a list of files from $LIST in the $DIRFILE, transforms using insert.awk file and executes the result using DB2 connection.

### transformdb2 function

https://github.com/stanislawbartkowski/migrawk/blob/master/proc.sh

The function is shared by both bash scripts. Executes the awk transformation script and the result is executed by DB2.<br>

Additional feature: if ICONV variable is set then before the transformation *iconv* Linux utility is executed to change the MS SQL script character encoding.
