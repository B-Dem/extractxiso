@echo off
REM Demander à l'utilisateur de spécifier le fichier ISO source
set /p source=Entrez le chemin complet de l'ISO (ex: C:/chemin/vers/ton/iso.iso) :

REM Extraire le dossier contenant l'ISO
for %%F in ("%source%") do set "folder=%%~dpF"

REM Extraire le nom du fichier sans l'extension
for %%F in ("%source%") do set "filename=%%~nF"

REM Créer un dossier d'extraction dans le même dossier que l'ISO
set "extractFolder=%folder%%filename%"

REM Extraire les fichiers de l'ISO dans le dossier d'extraction
echo Extraction de l'ISO dans le dossier : %extractFolder%
extract-xiso -x "%source%"
if %ERRORLEVEL% neq 0 (
    echo Une erreur est survenue pendant l'extraction !
    pause
    exit /b
)

echo Les fichiers ont été extraits avec succès dans : %extractFolder%
timeout /t 1

REM Créer le fichier XISO à partir du dossier d'extraction
echo Création du XISO à partir de : %extractFolder%
set "outputXISO=%folder%XISO-%filename%.iso"
extract-xiso -c "%extractFolder%" "%outputXISO%"
if %ERRORLEVEL% neq 0 (
    echo Une erreur est survenue pendant la création du XISO !
    pause
    exit /b
)

echo Le XISO a été créé avec succès à : %outputXISO%
pause
