@echo on

setlocal

set PATH=%PATH%;%PROGRAMFILES%\Git\bin
set PATH=C:\Ruby30-x64\bin;%PATH%
set PATH=C:\Ruby30-x64\msys64\usr\bin;%PATH%
set PATH=C:\Ruby30-x64\msys64\mingw64\bin;%PATH%
set PATH=%PATH%;%USERPROFILE%\go\bin

echo %PATH%

call rake %*

echo ERRORLEVEL=%ERRORLEVEL%

if not "%ERRORLEVEL%" == "0" pause
