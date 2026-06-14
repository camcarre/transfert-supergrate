@echo off
chcp 65001 >nul
title Preparation PC - Transfert SuperGrate

echo ================================================
echo  PREPARATION DU PC POUR LE TRANSFERT SUPERGRATE
echo  A LANCER EN ADMINISTRATEUR
echo  (clic droit sur ce fichier ^> Executer en tant
echo   qu'administrateur)
echo ================================================
echo.

REM --- Verifie les droits administrateur ---
net session >nul 2>&1
if %errorLevel% neq 0 (
  echo [ERREUR] Ce script n'est PAS lance en administrateur.
  echo.
  echo   Ferme cette fenetre, fais un CLIC DROIT sur preparer-pc.bat
  echo   puis "Executer en tant qu'administrateur".
  echo.
  pause
  exit /b 1
)

echo [1/4] Mise du reseau en mode PRIVE...
powershell -NoProfile -Command "Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private" 2>nul

echo [2/4] Activation Partage de fichiers + Decouverte reseau...
netsh advfirewall firewall set rule group="Partage de fichiers et d'imprimantes" new enable=Yes >nul 2>&1
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes >nul 2>&1
netsh advfirewall firewall set rule group="Decouverte de reseau" new enable=Yes >nul 2>&1
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes >nul 2>&1

echo [3/4] Autorisation du PING (ICMP)...
netsh advfirewall firewall add rule name="Autoriser Ping ICMPv4" protocol=icmpv4:8,any dir=in action=allow >nul 2>&1

echo [4/4] Deblocage acces admin reseau (LocalAccountTokenFilterPolicy)...
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo ================================================
echo  TERMINE. Tous les reglages sont appliques.
echo.
echo  >> Refais EXACTEMENT la meme chose sur l'AUTRE PC. <<
echo.
echo  Ensuite : verifie le ping entre les 2 PC, puis
echo  lance SuperGrate sur le PC qui recoit.
echo ================================================
echo.
echo  Ton adresse IP sur ce PC :
ipconfig | findstr /C:"IPv4"
echo.
pause
