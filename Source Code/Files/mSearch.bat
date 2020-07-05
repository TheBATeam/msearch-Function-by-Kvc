@echo off

:: This file is created by Kvc, on 5:24 PM 7/24/2015... on the request on our facebook page...
:: don't use this file for any illegal purpose...as the author will not be responsible for
:: any damage you've done... on any computer using this file... as This is only for educational
:: purpose...

:: if you wanna publish this file on your website / blog or any other media... You have to mention
:: our link 'www.thebateam.org' with this post...

:: this file is Given under the GNU licnce of Software products... search google for its terms...
:: hence licensed free-ware...

:: if you don't agree with any  point... delete / remove / don't use this file...

:: #kvc

set title=File replacing utility by kvc
title %title%
setlocal enabledelayedexpansion

set Quiet_mode=
set command_mode=N

if not exist "!temp!\kvc" (md "!temp!\kvc")

rem setting up arguments for working as a command...
if /i "%~1" == "" (goto top)
if /i "%~2" == "" (goto help)

if /i "%~1" == "/?" (goto help)
if /i "%~1" == "-h" (goto help)
if /i "%~1" == "/h" (goto help)
if /i "%~1" == "help" (goto help)

set "file_old=%~1"

set "file_path=%~2"
if not exist "!file_path!" (exit /b 1)

if /i "%~3" == "/Q" (set "Quiet_mode=%~3")
if /i "%~3" == "-Q" (set "Quiet_mode=%~3")
set command_mode=Y

goto top_2
:top
set file_old=
set file_new=
set file_path=

:top_2
del /s /q "!temp!\kvc\*.*" 2>nul
cls
if not defined file_old (
echo.
echo.
echo. Please enter the name of File to replace [E.g. abc.ppt]:
set /p "file_old= :>"
if not defined file_old (goto top)
set "file_old=!file_old:"=!"
cls
)
for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
	if exist "%%A:" (
	if not defined Quiet_mode (
	echo.
	echo. Searching for ^(!file_old!^) file in This Pc...
	echo.
	rem Saving location of all files with same name to another file
	echo. Searching in %%A: Drive ...
	)
	cd /d %%A:
	cd /
	dir "!file_old!" /s /b /a:h>>"!temp!\kvc\Database.kvc" 2>nul
	dir "!file_old!" /s /b /a:-h>>"!temp!\kvc\Database.kvc" 2>nul
	cls
	)
)
cls
set count=0
for /f "tokens=*" %%A in (!temp!\kvc\Database.kvc) do set /a count+=1

if not defined Quiet_mode (
echo.
echo. Total !count! files found in this Pc named:
echo. [!file_old!]
echo.
if /i "!count!" == "0" (
	echo. No file FOund... Nothing to replace...
	echo. Wanna Try again??? Or Exit...
	:middle
	choice /c TE /n /m "Press 'T' or 'E' :"
	if !errorlevel! equ 0 (echo. Invalid Key...&& goto middle)
	if !errorlevel! equ 1 (goto top)
	exit 404
)
more "!temp!\kvc\Database.kvc"
goto top_3
)

if /i "!count!" == "0" (exit /b 404)

:top_3
if not defined Quiet_mode (
echo.
echo.
echo. Do you want to Over-write them all?? [They can't be recovered Back...]
:bottom
choice /c yn /n /m "[ Y / N ] :"
if /i "!errorlevel!" == "1" (goto next)
if /i "!errorlevel!" == "2" (goto top)
goto bottom
)

:next
if /i "!command_mode!" == "N" (
cls
echo.
echo.
echo. Copy-Paste Path of file to Replace:
set /p "file_path= :"
if not defined file_path goto next
if not exist "!file_path!" (echo. File not Found...&&timeout /t 1 && goto next)
)

rem Replacing module...
set count_2=0
for /f "tokens=*" %%A in (!temp!\kvc\Database.kvc) do (
	Del /q "%%A"
	copy /y "!file_path:"=!" "%%A"
	set /a count_2+=1
	title %title% [ Replaced !count_2!/!count! ]
)

if /i "!command_mode!" == "N" (
echo.
echo.
echo. All Done !!! Enjoy... #kvc
pause
exit 0
)
echo. Done !!
title !cd!
exit /b 0


:help
echo.
echo.
echo. This mSearch module is Created by Kvc...On the request of 'Yasir' and
echo 'Richard'... on www.thebateam.org
echo.
echo. Syntax to use:
echo.
echo. mSearch "Filename.ext" "Filepath" [/Q ^| -Q]
echo.                     Or
echo. mSearch [/? ^| -h ^| /h ^| Help]
echo.
echo. Where:
echo. Filename.ext	:	The name of the File to search.
echo. Filepath	:	The full / Relative path of the file to replace
echo				the previous searched file.
echo. '/Q' or '-Q'	:	To perform all actions in Quiet Mode
echo.				It will not confirm before replacing...
echo. '/h' or '-h' or '/?':	to see this help menu...
echo.
echo. If file_not_found...it will return errorcode '404'
echo. If the path specified to file for replacing is invalid, then errorcode
echo. will be '1'.
echo. Else it will return errorcode '0'.
echo.
echo. Thanks for using...#kvc 
