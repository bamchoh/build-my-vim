@echo off

setlocal

set PATH=%PATH%;%PROGRAMFILES%\Git\bin
set PATH=%PATH%;C:\msys64\mingw64\bin
set PATH=%PATH%;C:\msys64\usr\bin
set PATH=%PATH%;C:\Ruby25-x64\bin

rake
