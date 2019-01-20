@echo off

setlocal

set PATH=%PATH%;%PROGRAMFILES%\Git\bin
set PATH=C:\Ruby25-x64\bin;%PATH%
set PATH=C:\msys64\usr\bin;%PATH%
set PATH=C:\msys64\mingw64\bin;%PATH%

echo %PATH%

rake %*
