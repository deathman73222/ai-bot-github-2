@echo off
REM AI Bot Installation Script for Windows
REM This script sets up the AI Bot application with all dependencies

setlocal enabledelayedexpansion

cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║            AI Bot Installation Wizard                      ║
echo ║         Professional Setup Assistant for Windows           ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Python is not installed or not in PATH
    echo Please install Python 3.7+ from https://www.python.org/
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)

echo ✓ Python found
python --version

REM Check if pip is available
python -m pip --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: pip is not available
    pause
    exit /b 1
)

echo ✓ pip found
echo.

REM Install/upgrade PyQt5 for GUI
echo Installing PyQt5...
python -m pip install --upgrade PyQt5 -q
if errorlevel 1 (
    echo ⚠️  Warning: Could not install PyQt5. This is required for GUI.
) else (
    echo ✓ PyQt5 installed
)

REM Install Pillow for icon generation
echo Installing Pillow...
python -m pip install --upgrade Pillow -q
if errorlevel 1 (
    echo ⚠️  Warning: Could not install Pillow
) else (
    echo ✓ Pillow installed
)

REM Install requests for web search
echo Installing requests...
python -m pip install --upgrade requests -q
if errorlevel 1 (
    echo ⚠️  Warning: Could not install requests
) else (
    echo ✓ requests installed
)

REM Generate icons
echo.
echo Generating application icons...
python create_icon.py

REM Run the actual installer
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║   Launching AI Bot Installation Wizard...                  ║
echo ║   (This will open the setup window)                        ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

python installer.py

if errorlevel 1 (
    echo ❌ Installation failed
    pause
    exit /b 1
)

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║           ✓ Installation Complete!                         ║
echo ║                                                              ║
echo ║  AI Bot has been successfully installed on your system.    ║
echo ║                                                              ║
echo ║  You can now run:                                          ║
echo ║  • python run_ai_bot.py      (GUI version)                 ║
echo ║  • python cli_interface.py   (CLI version)                 ║
echo ║  • Desktop shortcut (if created)                           ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

pause
