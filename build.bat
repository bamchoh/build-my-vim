@echo off

setlocal

doskey ls=ls --color=auto --show-control-chars -N $*
doskey grep=grep --color=auto $*
doskey rm=rm -i $*
doskey cp=cp -i $*
doskey mv=mv -i $*
doskey vi=vim $*
doskey find=c:/msys64/usr/bin/find.exe $*
doskey ag=d:\apps\ag

set PATH=%PATH%;%PROGRAMFILES%\Git\bin
set PATH=%PATH%;C:\msys64\mingw64\bin
set PATH=%PATH%;C:\msys64\usr\bin
set LUA_VERSION=51
set LUAPATH=c:/dev/lua%LUA_VERSION%/src
set PY3_VER=37
set PY3PATH=%LOCALAPPDATA%/Programs/Python/Python%PY3_VER%-32

git clone https://github.com/vim/vim

if "%ERRORLEVEL%" == "128" (
  echo "Git Pull"
  cd vim\src
  git pull
) else (
  cd vim\src
)

REM gvim.exe
echo Start to build gvim.exe
make -f Make_ming.mak clean
make -f Make_ming.mak TERMINAL=yes STATIC_STDCPLUS=yes DEBUG=no LUA=%LUAPATH% DYNAMIC_LUA=yes LUA_VER=%LUA_VERSION% PYTHON3=%PY3PATH% DYNAMIC_PYTHON3=yes PYTHON3_VER=%PY3_VER%

if exist gvim.exe (
  mv C:/Vim/gvim.exe C:/Vim/gvim_old.exe
	mv gvim.exe C:/Vim/gvim.exe
)

REM vim.exe
echo Start to build vim.exe
make -f Make_ming.mak clean
make -f Make_ming.mak GUI=NO TERMINAL=yes STATIC_STDCPLUS=yes DEBUG=no LUA=%LUAPATH% DYNAMIC_LUA=yes LUA_VER=%LUA_VERSION% PYTHON3=%PY3PATH% DYNAMIC_PYTHON3=yes PYTHON3_VER=%PY3_VER%

if exist vim.exe (
  mv C:/Vim/vim.exe C:/Vim/vim_old.exe
	mv vim.exe C:/Vim/vim.exe
)
