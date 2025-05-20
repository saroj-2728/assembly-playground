@echo off
REM run.bat: Run an assembled 8086 ASM executable inside DOSBox.
REM Usage: run.bat path\to\source.asm

if "%~1"=="" (
    echo Usage: %~nx0 ^<asm_file^>
    exit /b 1
)

REM Get the input assembly file
set ASMFILE=%1

REM Convert forward slashes to backslashes for DOS compatibility
set ASMFILE=%ASMFILE:/=\%

REM Get the basename (without extension)
for %%F in (%ASMFILE%) do set BASENAME=%%~nF

REM Get the workspace folder (current working directory)
set WORKSPACE=%CD%

REM Ensure 'bin' folder exists
if not exist "%WORKSPACE%\bin" mkdir "%WORKSPACE%\bin"

echo Running ASM executable: bin\%BASENAME%.exe
echo Workspace: %WORKSPACE%

REM Launch DOSBox and run the executable:
dosbox -c "mount c \"%WORKSPACE%\"" ^
       -c "c:" ^
       -c "cd tools" ^
       -c "debug ..\bin\%BASENAME%.exe"
