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

Tranforms sequence of INSERT in MS SQL format into DB2 supported syntax.
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


## Prerequisites

* DB2 instance and database up and running
* DB2 command line parameter should be installed

## Installation

Clone repository

> git clone https://github.com/stanislawbartkowski/migrawk.git<br>
> cd migrawk<br>
> cp templates/* .<br>

Modify source.rc, run.sh and run1.sh according to environment.

### Configuration, source.rc




