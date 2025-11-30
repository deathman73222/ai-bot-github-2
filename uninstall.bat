@echo off
REM AI Bot - Uninstaller (Windows)
REM This script attempts to remove the application folder, shortcuts and optional Python packages.

setlocal enabledelayedexpansion

echo ==================================================
echo AI Bot - Uninstaller
echo ==================================================
echo This will remove the AI Bot installation and related files.
echo Make sure the application is NOT running before continuing.
echo.
set DEFAULT_PATH=%USERPROFILE%\AI Bot
set /p INSTALL_DIR=Enter installation path to remove [Default: %DEFAULT_PATH%]:
if "%INSTALL_DIR%"=="" set INSTALL_DIR=%DEFAULT_PATH%

echo.
echo You are about to remove: "%INSTALL_DIR%"
set /p CONFIRM=Type Y to confirm and continue, any other key to abort: 
if /I not "%CONFIRM%"=="Y" (
    echo Aborted by user.
    goto :EOF
)

echo Stopping common AI Bot processes (if running)...
REM Attempt to stop a likely executable or known python script. May fail silently if not present.
tasklist 2>nul | findstr /I "AIBot.exe" >nul && (
    echo Terminating AIBot.exe ...
    taskkill /IM AIBot.exe /F >nul 2>&1
)

echo Deleting installation directory: "%INSTALL_DIR%"
if exist "%INSTALL_DIR%" (
    rmdir /S /Q "%INSTALL_DIR%"
    if exist "%INSTALL_DIR%" (
        echo Warning: could not fully remove "%INSTALL_DIR%". Some files may be in use.
    ) else (
        echo Removed installation directory.
    )
) else (
    echo Installation directory does not exist: "%INSTALL_DIR%"
)

echo Removing desktop shortcut (if exists)...
set DESKTOP_SHORTCUT=%USERPROFILE%\Desktop\AI Bot.lnk
if exist "%DESKTOP_SHORTCUT%" (
    del /F /Q "%DESKTOP_SHORTCUT%"
    echo Desktop shortcut removed.
) else (
    echo No desktop shortcut found.
)

echo Removing Start Menu shortcuts (if any)...
set START_MENU_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\AI Bot
if exist "%START_MENU_FOLDER%" (
    rmdir /S /Q "%START_MENU_FOLDER%"
    echo Start Menu entries removed.
) else (
    echo No Start Menu entries found.
)

echo.
set /p REMOVE_PIP=Do you want to attempt uninstalling Python packages listed in requirements.txt? (Y/N): 
if /I "%REMOVE_PIP%"=="Y" (
    if exist "%~dp0requirements.txt" (
        echo Running pip uninstall -r requirements.txt ...
        REM Try using the same python used to run this script if available next to the script
        if exist "%~dp0python.exe" (
            "%~dp0python.exe" -m pip uninstall -r "%~dp0requirements.txt" -y
        ) else (
            python -m pip uninstall -r "%~dp0requirements.txt" -y
        )
        echo Pip uninstall attempted.
    ) else (
        echo requirements.txt not found next to this script; skipping pip uninstall.
    )
)

echo.
echo Uninstallation finished. Please review the messages above for any issues.
pause

endlocal
