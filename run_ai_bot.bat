@echo off
REM Windows batch file to run AI Bot
REM This script activates the virtual environment and launches the app

setlocal enabledelayedexpansion

cd /d "%~dp0"

REM Check if venv exists
if exist "venv\Scripts\activate.bat" (
    echo Activating virtual environment...
    call venv\Scripts\activate.bat
) else (
    echo Virtual environment not found. Creating one...
    python -m venv venv
    call venv\Scripts\activate.bat
    echo Installing requirements...
    pip install -r requirements.txt
)

echo Starting AI Bot...
python run_ai_bot.py

pause
