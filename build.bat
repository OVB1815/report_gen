@echo off
echo Building report...
.venv\Scripts\python.exe build_report.py
if %errorlevel% neq 0 (
    echo ERROR: Python script failed. See message above.
    pause
    exit /b 1
)
typst compile report.typ
if %errorlevel% neq 0 (
    echo ERROR: Typst compile failed. See message above.
    pause
    exit /b 1
)
echo.
echo Done. report.pdf is ready.
pause
