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

if not exist "C:\transfert" mkdir "C:\transfert"
set "OUT=C:\transfert\programmes.json"
set "TXT=C:\transfert\programmes-lisible.txt"

echo Creation de la liste des programmes... patiente.
echo.
winget export -o "%OUT%" --accept-source-agreements

echo Creation de la liste lisible (a lire)...
winget list > "%TXT%" 2>&1

echo.
echo ================================================
echo  TERMINE.
echo  Fichiers crees dans le dossier :  C:\transfert
echo    - programmes.json          (pour reinstaller auto)
echo    - programmes-lisible.txt   (la liste a lire)
echo.
echo  Pour ouvrir le dossier : copie-colle C:\transfert
echo  dans la barre d'adresse de l'Explorateur.
echo.
echo  >> Copie "programmes.json" sur le PC NEUF <<
echo     (cle USB, ou via le partage reseau)
echo ================================================
start "" "C:\transfert"
pause
