REM 1. Add the software path in line 10
REM 2. Change the rule name in line 38
REM 3. Run as Admin


@echo off
setlocal enabledelayedexpansion

REM EDIT THIS PATH
set "FolderPath=C:\"


net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as Administrator.
    pause
    exit /b 1
)

if not exist "%FolderPath%" (
    echo Folder not found: %FolderPath%
    pause
    exit /b 1
)

echo Scanning "%FolderPath%" for executables...
echo.

set count=0

for /r "%FolderPath%" %%F in (*.exe *.scr *.com) do (
    set /a count+=1
    set "fname=%%~nxF"
    set "fpath=%%~fF"

REM Enter the firewall rule name here
    netsh advfirewall firewall add rule ^
        name="NAME-!fname!-!count!" ^
        dir=out ^
        action=block ^
        program="!fpath!" ^
        enable=yes ^
        profile=domain,private,public

    echo Blocked: !fpath!
)

echo.
echo Total executables blocked: !count!
echo.

echo The following script-type files were found but NOT blocked
echo (firewall rules can't target scripts directly, only their interpreter):
for /r "%FolderPath%" %%F in (*.bat *.cmd *.ps1 *.vbs *.js) do (
    echo   %%~fF
)

echo.
echo Done.
pause
