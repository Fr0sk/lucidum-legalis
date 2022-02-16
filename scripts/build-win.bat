:: Prompt for app version check
@echo off
setlocal
SET /P VERSIONBUMP=Do not forget to update the app version. Continue (Y/[N])?
if /I "%VERSIONBUMP%" NEQ "Y" GOTO END


:: START BUILD SCRIPT
cd ..

:: Create updater.exe and move it to the build directory
cd updater
call dart pub get
call dart compile exe bin\updater.dart
cd ..
move /y updater\bin\updater.exe build\windows\runner\Release\updater.exe

:: Build Flutter app for Windows
call flutter packages pub get
call flutter build windows

:: Copy the sqlite3.dll to the build directory
copy /y sqlite3.dll build\windows\runner\Release\sqlite3.dll

:: Creates the build\out dir
mkdir build\out

:: Create zip file and move it to out directory
powershell Compress-Archive -Force build\windows\runner\Release\* build\out\lucidum_legalis_win64.zip

:: Writes to console the out path for easier navigation
echo:
echo lucidum_legalis_win64.zip file created on \build\out

:: Opens explorer on the folder
echo Opening directory...
start build\out\

cd scripts
:: END BUILD SCRIPT

:END
endlocal
