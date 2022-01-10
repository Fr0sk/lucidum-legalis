cd ..

::call flutter packages pub get
::call flutter build windows
copy /y sqlite3.dll build\windows\runner\Release\sqlite3.dll

tar -a -cf lucidum_legalis_win64.zip build\windows\runner\Release
mkdir build\out
move /y lucidum_legalis_win64.zip build\out\lucidum_legalis_win64.zip

cd scripts