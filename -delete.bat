:: DELETE /repos/:owner/:repo
set GIT_USER=%~1
set PROJ=%~2
FOR /f "tokens=1,2 delims=/" %%a IN ("%PROJ%") do set ORG=%%a&set PROJECT=%%b
if "%PROJECT%"=="" (
set PROJECT=%~2
set ORG=
set PROJ_FOLDER=%PROJECT%
) else (
set PROJ_FOLDER=%ORG%-%PROJECT%
)
::@ping -n 4 localhost> nul &&
RMDIR /Q/S %PROJ_FOLDER%
if "%ORG%"=="" (
.apicra\curl-7.65.0-win32-mingw\bin\curl.exe -u "%GIT_USER%" -X DELETE https://api.github.com/repos/%GIT_USER%/%PROJECT%
) else (
.apicra\curl-7.65.0-win32-mingw\bin\curl.exe -u "%GIT_USER%" -X DELETE https://api.github.com/repos/%ORG%/%PROJECT%
)
