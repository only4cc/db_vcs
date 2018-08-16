set SERVERNAME=%1
set USERNAME=%2
set PASS=%3

"C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\sqlcmd.exe"  -s "," -W -h-1  -H %SERVERNAME% -S %SERVERNAME% -d master -U %USERNAME% -P %PASS%  -t 3 -i C:\e-contact\admin\mssql-scripter\db_scv\dbnames.sql -o C:\e-contact\admin\mssql-scripter\db_scv\dbnames.txt