@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Copie des fichiers - Ancien PC vers ce PC

echo ================================================
echo   COPIE AUTOMATIQUE DES FICHIERS
echo   De l'ancien PC vers CE PC (via robocopy)
echo   A lancer sur le PC qui RECOIT.
echo ================================================
echo.

REM --- Demande les infos ---
set /p SRCIP=Adresse IP de l'ancien PC [172.20.10.7] :
if "%SRCIP%"=="" set SRCIP=172.20.10.7

set /p SRCUSER=Nom du dossier utilisateur sur l'ancien PC (ex: camille) :
if "%SRCUSER%"=="" (
  echo [ERREUR] Il faut donner le nom du dossier utilisateur.
  pause & exit /b 1
)

set /p ADMINUSER=Compte admin de l'ancien PC (souvent le meme nom) :
if "%ADMINUSER%"=="" set ADMINUSER=%SRCUSER%

echo.
echo Une fenetre va demander le MOT DE PASSE de l'ancien PC.
echo.

REM --- Nettoie une eventuelle ancienne connexion, puis se connecte ---
net use \\%SRCIP%\c$ /delete /y >nul 2>&1
net use \\%SRCIP%\c$ /user:%SRCIP%\%ADMINUSER%
if errorlevel 1 (
  echo.
  echo [ERREUR] Connexion impossible.
  echo Verifie : IP, nom du compte, mot de passe.
  pause & exit /b 1
)

set "SRC=\\%SRCIP%\c$\Users\%SRCUSER%"
set "DST=%USERPROFILE%"
set "LOG=%USERPROFILE%\Desktop\copie-log.txt"

echo.
echo ================================================
echo  Source      : %SRC%
echo  Destination : %DST%
echo  Journal     : %LOG%
echo ================================================
echo.
echo  Copie en cours... ca peut etre LONG.
echo  Laisse tourner, garde les 2 PC sur le hotspot.
echo.

REM --- Copie chaque dossier perso (AppData est ignore automatiquement) ---
for %%F in (Desktop Documents Downloads Pictures Music Videos Favorites Links Contacts Searches) do (
  if exist "%SRC%\%%F" (
    echo --- Copie de %%F ---
    robocopy "%SRC%\%%F" "%DST%\%%F" /E /R:1 /W:1 /XJ /NFL /NDL /NP /TEE /LOG+:"%LOG%"
  )
)

echo.
echo ================================================
echo  COPIE TERMINEE.
echo  Detail complet dans : %LOG%
echo  (sur le Bureau de ce PC)
echo ================================================
net use \\%SRCIP%\c$ /delete /y >nul 2>&1
echo.
pause
