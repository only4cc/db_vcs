@echo off
REM
REM   JTS 03-Mayo-2018
REM 

set SERVERNAME=%1
set USERNAME=%2
set PASS=%3
set ORG=%4

set DIREXP=C:\e-contact\admin\mssql-scripter\exp2
set DIRSANDBOX=%DIREXP%\dba-structure

REM limpia contenido del directorio
@echo on
echo limpia contenido del directorio
del %DIREXP%\local\%ORG%\%SERVERNAME%\*.sql 

REM Genera nombres de las bbdd en SERVERNAME
del /F C:\e-contact\admin\mssql-scripter\db_scv\dbnames.txt
call C:\e-contact\admin\mssql-scripter\db_scv\dbnames.bat %SERVERNAME% %USERNAME% %PASS%

REM Extrae DDLs de todas las bbdd del servidor
perl C:\e-contact\admin\mssql-scripter\db_scv\exp.pl %SERVERNAME% %USERNAME% %PASS% %ORG%

copy  %DIREXP%\local\%ORG%\%SERVERNAME%\*.sql   %DIRSANDBOX%\%ORG%\%SERVERNAME%\

REM git pull -v https://github.com/e-contact/dba-structure  master

REM timeout 5
del %DIRSANDBOX%\.git\index.lock 

REM Actualiza TFS
cd %DIRSANDBOX%

git status

cd  %DIRSANDBOX%
REM git add --force  -v "%DIREXP%\%ORG%\*"  
REM git add --force  -v "%DIREXP%\*"  
git add -v .  
REM timeout 3

git status

git commit -m "Cambios en %SERVERNAME% - %date%" 
REM timeout 3

git status

git push -v --force https://github.com/e-contact/dba-structure  master
REM timeout 3

cd C:\e-contact\admin\mssql-scripter\db_scv


