@echo off
setlocal

REM Check argument count
if "%~2"=="" (
    echo Copies all the required files to the given directory, renaming the project to "project_name".
    echo Usage: copy_to_project.bat directory project_name
    goto :eof
)

REM Check if directory exists
if not exist "%~1\" (
    echo Error: the directory %~1 does not exist.
    goto :eof
)

REM Get script directory
set "BASEDIR=%~dp0"
REM Remove trailing backslash if present
if "%BASEDIR:~-1%"=="\" set "BASEDIR=%BASEDIR:~0,-1%"

REM Copy necessary files and directories
echo Copying .vscode directory...
xcopy "%BASEDIR%\.vscode" "%~1\.vscode" /E /I /Y >nul

echo Copying .gitignore...
copy /Y "%BASEDIR%\.gitignore" "%~1\" >nul
echo Copying CMakeLists.txt...
copy /Y "%BASEDIR%\CMakeLists.txt" "%~1\" >nul
echo Copying LICENSE...
copy /Y "%BASEDIR%\LICENSE" "%~1\" >nul
echo Copying README.md...
copy /Y "%BASEDIR%\README.md" "%~1\" >nul

echo Copying main.cpp...
copy "%BASEDIR%\main.cpp" "%~1\" >nul
if errorlevel 1 (
    echo Error: main.cpp could not be copied. Please check if it exists in the source directory.
)

REM Replace "wx_cmake_template" with project name in all files
echo Replacing project name in files...
for /R "%~1" %%F in (*) do (
    if /I not "%%~dpF"=="%~1\.git\" if /I not "%%~dpF"=="%~1\build\" (
        powershell -Command "(Get-Content -Raw -Encoding UTF8 '%%F') -replace 'wx_cmake_template', '%~2' | Set-Content -Encoding UTF8 '%%F'"
    )
)

echo All files processed successfully.
endlocal