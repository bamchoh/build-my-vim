@echo on

setlocal

set PATH=%PATH%;%PROGRAMFILES%\Git\bin
set PATH=C:\Ruby26-x64\bin;%PATH%
set PATH=C:\msys64\usr\bin;%PATH%
set PATH=C:\msys64\mingw64\bin;%PATH%

echo %PATH%

call rake %*

echo ERRORLEVEL=%ERRORLEVEL%

if not "ERRORLEVEL" == "0" pause
