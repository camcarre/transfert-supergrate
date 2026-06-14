@echo off
chcp 65001 >nul
title Lister les programmes - ANCIEN PC

echo ================================================
echo   LISTE DES PROGRAMMES
echo   A LANCER SUR L'ANCIEN PC (172.20.10.7)
echo ================================================
echo.

REM --- Verifie que winget existe ---
where winget >nul 2>&1
if errorlevel 1 (
  echo [ERREUR] winget n'est pas disponible sur ce PC.
  echo Ouvre le Microsoft Store, cherche "App Installer",
  echo installe-le / mets-le a jour, puis relance ce script.
  pause & exit /b 1
)

set "OUT=%USERPROFILE%\Desktop\programmes.json"
set "TXT=%USERPROFILE%\Desktop\programmes-lisible.txt"

echo Creation de la liste des programmes... patiente.
echo.
winget export -o "%OUT%" --accept-source-agreements

echo Creation de la liste lisible (a lire)...
winget list > "%TXT%" 2>&1

echo.
echo ================================================
echo  TERMINE.
echo  Fichiers crees sur ton BUREAU :
echo    - programmes.json          (pour reinstaller auto)
echo    - programmes-lisible.txt   (la liste a lire)
echo.
echo  >> Copie "programmes.json" sur le PC NEUF <<
echo     (cle USB, ou via le partage reseau)
echo ================================================
pause
