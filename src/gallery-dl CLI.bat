@echo off

title gallery-dl CLI

:ProgramCheck
if exist "gallery-dl.exe" goto :MainMenu
cls & color 0c
set /p choice="gallery-dl.exe not found! Download now? "
if /i "%choice%" equ "Y" goto :Download
if /i "%choice%" equ "N" exit /b
cls
echo You must enter 'y' or 'n' to proceed... & pause > nul
goto :ProgramCheck

:Download
cls & color 0e
echo Download and extract gallery-dl contents to the same directory as this script.
start /wait https://github.com/mikf/gallery-dl/releases/latest
pause
goto :ProgramCheck

:MainMenu
set "Choice="
cls & color 1f & mode con cols=58 lines=11
echo     __________________________________________________
echo    /                                                  \
echo    ^|                    Main Menu                     ^|
echo    ^|--------------------------------------------------^|
echo    ^| Download ..................................... 1 ^|
echo    ^| Run .......................................... 2 ^|
echo    ^| Help ......................................... 3 ^|
echo    \__________________________________________________/
echo.
set /p "Choice=Enter option: "
if /i "%Choice%" equ "1" goto :DownloadPrompt
if /i "%Choice%" equ "2" goto :RunProgram
if /i "%Choice%" equ "3" goto :PrintHelp
cls & color 0c & echo.
echo You must enter an option to proceeed! & pause > nul
goto :MainMenu

:DownloadPrompt
set "URL="
cls& color 0e & mode con cols=140 lines=30 & echo.
echo ^*Append multiple URLs by separating with spaces.
echo ^*Enter -r to return to previous menu.
set /p "URL=Enter URL: "
if /i "%URL%" equ "-r" goto :MainMenu
if /i "%URL%" neq "" goto :GalleryDownload
cls & color 0c & echo.
echo You must enter a URL to proceeed! & pause > nul
goto :DownloadPrompt

:GalleryDownload
cls & color 0e & mode con cols=140 lines=30 & echo.
echo Download in progress...
echo.
"gallery-dl.exe" --dest "%userprofile%\Pictures\gallery-dl" --cookies="cookies.txt" %URL%
if %errorlevel% equ 0 (cls & color 0a & echo. & echo Downloading completed. & pause > nul & start "" explorer "%userprofile%\Pictures\gallery-dl") else (echo. & pause)
goto :MainMenu

:RunProgram
cls
start "" cmd /k
goto :MainMenu

:PrintHelp
cls
"gallery-dl.exe" -h>"help.txt"
if %errorlevel% equ 0 (start "" notepad "help.txt") else (echo. & pause)
goto :MainMenu
