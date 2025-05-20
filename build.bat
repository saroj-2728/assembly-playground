@echo off
REM build.bat: Assemble and link an 8086 ASM file using MASM inside DOSBox.
REM Usage: build.bat path\to\source.asm

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

echo Building ASM file: ..\%ASMFILE%
echo Basename: %BASENAME%
echo Workspace: %WORKSPACE%

REM Launch DOSBox and run the build commands:
dosbox -c "mount c \"%WORKSPACE%\"" ^
       -c "c:" ^
       -c "cd tools" ^
       -c "masm ..\%ASMFILE%, ..\bin\%BASENAME%.obj;" ^
       -c "link ..\bin\%BASENAME%.obj, ..\bin\%BASENAME%.exe;" ^
