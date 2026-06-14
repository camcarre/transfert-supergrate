@echo off
chcp 65001 >nul
title Reinstaller les programmes - PC NEUF

echo ================================================
echo   REINSTALLATION DES PROGRAMMES
echo   A LANCER SUR LE PC NEUF (172.20.10.6)
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

set "IN=C:\transfert\programmes.json"
if not exist "%IN%" set "IN=%USERPROFILE%\Desktop\programmes.json"
if not exist "%IN%" (
  echo [ERREUR] Fichier "programmes.json" introuvable.
  echo.
  echo Mets le fichier "programmes.json" (cree sur l'ancien PC)
  echo dans C:\transfert (ou sur le Bureau) de ce PC,
  echo puis relance ce script.
  pause & exit /b 1
)
echo Fichier utilise : %IN%

echo Reinstallation en cours... ca peut etre LONG.
echo Laisse tourner. Certaines apps demanderont une validation.
echo.
winget import -i "%IN%" --accept-package-agreements --accept-source-agreements

echo.
echo ================================================
echo  TERMINE.
echo  Les programmes que winget ne connait pas n'ont
echo  pas ete installes : regarde "programmes-lisible.txt"
echo  et installe-les a la main (ex: logiciels payants,
echo  pilotes, jeux hors store).
echo ================================================
pause
