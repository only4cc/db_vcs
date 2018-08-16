For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c_%%a_%%b)
REM For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set TS=%mydate%

REM compact /C /I /S:C:\e-contact\admin\mssql-scripter\exp\local 

robocopy C:\e-contact\admin\mssql-scripter\exp\local  C:\e-contact\admin\mssql-scripter\tmp\local  /MIR
compact /C /I /S:C:\e-contact\admin\mssql-scripter\tmp\local
rename C:\e-contact\admin\mssql-scripter\tmp\local local.%TS%

del /S C:\e-contact\admin\mssql-scripter\exp\local\*.sql