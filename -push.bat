:: update data on git repo
@ECHO OFF
SetLocal EnableDelayedExpansion
::-message.bat
for /f %%i in ('dir /b /od ticket\*.txt') do set filename=%%i
for /f "delims==" %%a in (ticket\%filename%) do set message=%%a
@ECHO ON
git add . && git commit -m "%message%" && git push origin master && -open-git-url.bat
:: GIT_URL.txt
