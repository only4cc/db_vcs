@echo off
REM
REM  Lista de servidores a incluir en el TFS
REM  JTS Mayo 2018
REM
set clave=wMqo7_c6D7Yl

@echo on

set user=eco_dba
set pgm=C:\e-contact\admin\mssql-scripter\db_scv\exp.bat

set DIREXP=C:\e-contact\admin\mssql-scripter\exp2
cd %DIREXP%\dba-structure

del %DIREXP%\dba-structure\.git\index.lock

call git stash
call git pull 

REM Labs    
call %pgm% soporte-21       sa     password1*   LAB
REM call %pgm% LAB-CG4          sa     password1*   LAB

REM goto:EOF

REM Claro
call %pgm% SQL-CLARO41 %user% %clave%  CLARO
call %pgm% G1DB601     %user% %clave%  CLARO
call %pgm% G1DB602     %user% %clave%  CLARO
call %pgm% SQL63       %user% %clave%  CLARO

call %pgm% SQL-CLARO43 E-CONTACT\SVC-SQL-CLARO43 nouser  CLARO
call %pgm% SQL-CLARO48 E-CONTACT\svc-sqlclaro48  nouser  CLARO
call %pgm% G1DB603     E-CONTACT\svc-G1DB603     nouser  CLARO
call %pgm% SQL64       E-CONTACT\svc-sql64       nouser  CLARO
call %pgm% BDTMX60     E-CONTACT\svc-bdtmx60     nouser  CLARO

REM CAAS
call %pgm% ECO-SQL-002     %user% %clave%   CAAS
call %pgm% ECO-SQL-004     %user% %clave%   CAAS
call %pgm% ECO-DBSERVICIOS %user% %clave%   CAAS

REM Lynn
call %pgm% lynn-prod23 %user% %clave%   CAAS
call %pgm% lynn-qa21   %user% %clave%   CAAS
call %pgm% lynn-des22  %user% %clave%   CAAS

REM VTR 
call %pgm% 172.17.233.184   %user% %clave%  VTR
call %pgm% 172.17.233.185   %user% %clave%  VTR
call %pgm% 172.17.233.186   %user% %clave%  VTR
call %pgm% 172.17.233.187   %user% %clave%  VTR
call %pgm% 172.17.233.188   %user% %clave%  VTR
call %pgm% 172.17.233.189   %user% %clave%  VTR
call %pgm% 172.17.233.190   %user% %clave%  VTR
call %pgm% 172.17.233.191   %user% %clave%  VTR
call %pgm% 172.17.233.192   %user% %clave%  VTR
                   
REM call %pgm% S1-ODSNOD01-VTR   %user% %clave% VTR
REM call %pgm% S1-ODSNOD02-VTR   %user% %clave% VTR
REM call %pgm% S1-ODSNOD03-VTR   %user% %clave% VTR

REM BE GTRD-Moneda
call  %pgm% BE0SQLP-V057A   %user% %clave%  BE
call  %pgm% BE0SQLP-V058A   %user% %clave%  BE
call  %pgm% BE0SQLP-V059A   %user% %clave%  BE
call  %pgm% BE0SQLP-V060A   %user% %clave%  BE
call  %pgm% BE0SQLP-V061A   %user% %clave%  BE
call  %pgm% BE0SQLP-V062A   %user% %clave%  BE

REM BE CDLV (sitio 1)
call  %pgm% BE0SQLP-V057C   %user% %clave%  BE
call  %pgm% BE0SQLP-V058C   %user% %clave%  BE
call  %pgm% BE0SQLP-V059C   %user% %clave%  BE
call  %pgm% BE0SQLP-V060C   %user% %clave%  BE
call  %pgm% BE0SQLP-V061C   %user% %clave%  BE
REM call  %pgm% BE0SQLP-V062C   %user% %clave%  BE

REM BE (sitio Lidice)
call  %pgm% BE0SQLP-V058L   %user% %clave%  BE
call  %pgm% BE0SQLP-V059L   %user% %clave%  BE
call  %pgm% BE0SQLP-V060L   %user% %clave%  BE
REM call  %pgm% BE0SQLP-V062L   %user% %clave%  BE

REM call  %pgm% REM call C:\e   %user% %clave%  BE-contact\admin\mssql-scripter\compacta.bat