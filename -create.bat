:: create git repo
set TICKET=first commit, based on .apicra tool
set /P DESCRIPTION= < ..\.apicra\variable\DESCRIPTION.txt
set GIT_USER=%~1
set PROJ=%~2
:: Prepare Variables
FOR /f "tokens=1,2 delims=/" %%a IN ("%PROJ%") do set ORG=%%a&set PROJECT=%%b
if "%PROJECT%"=="" (
set PROJECT=%~2
set ORG=
set PROJ_FOLDER=%PROJECT%
) else (
set PROJ_FOLDER=%ORG%-%PROJECT%
)
:: Make Request
if "%ORG%"=="" (
..\.apicra\curl-7.65.0-win32-mingw\bin\curl.exe -u "%GIT_USER%" https://api.github.com/user/repos -d "{\"name\":\"%PROJECT%\", \"description\":\"%DESCRIPTION%\"}"
set GIT_URL=https://github.com/%GIT_USER%/%PROJECT%.git
) else (
..\.apicra\curl-7.65.0-win32-mingw\bin\curl.exe -u "%GIT_USER%" https://api.github.com/orgs/%ORG%/repos -d "{\"name\":\"%PROJECT%\", \"description\":\"%DESCRIPTION%\"}"
set GIT_URL=https://github.com/%ORG%/%PROJECT%.git
)
git init
git add .
::git checkout -t -b develop origin/develop
git commit -m "%TICKET%"
:: echo %GIT_URL% > .apicra\variable\GIT_URL.txt
git remote add origin %GIT_URL%
::# Pushes the changes in your local repository up to the remote repository you specified as the origin
git push -u origin master
git remote -v
:: .apicra\-open-git-url.bat
mkdir .apicra
echo .apicra/ >> .gitignore
git clone https://github.com/apicra/npm-github-win.git .apicra
..\.apicra\-open.bat %GIT_URL%
::..\.apicra\-apicra-download.bat
