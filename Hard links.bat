@echo off
setlocal enabledelayedexpansion

:: ===============================
:: Grundeinstellungen
:: ===============================
set "target=S:\Turlte-Wow\WTF\Account\_ALL\"
set "dest=S:\Turlte-Wow\WTF\Account\"
set "server=Ambershire"

:: ===============================
:: KONFIGURATION: Accounts + Charaktere
:: ===============================
set "accounts=UNGWELOCK UNGWELIANT UNGEMAGE"

::set "chars_UNGWELOCK=Testingaddon"

set "chars_UNGWELOCK=Chlorofiend Lammoth Testingaddon Ungwelock"
set "chars_UNGWELIANT=Totemham Anarima"
set "chars_UNGEMAGE=Ungwebank Anglachal"


:: ===============================
:: Verarbeite Accounts und Charaktere
:: ===============================
for %%A in (%accounts%) do (
    set "account=%%A"

    :: hole dynamische variable chars_<accountname>
    call set "charlist=%%chars_%%A%%"

    if not defined charlist (
        echo [Ueberspringe] Account %%A hat keine definierten Charaktere.
        echo.
    ) else (
        echo Account: !account!
        for %%C in (!charlist!) do (
            set "character=%%C"
            echo Charakter: !character!

            :: Ordnerstruktur anlegen
            call :check_Folder "%dest%!account!\"
            call :check_Folder "%dest%!account!\SavedVariables"
            call :check_Folder "%dest%!account!\%server%\"
            call :check_Folder "%dest%!account!\%server%\!character!\"
            call :check_Folder "%dest%!account!\%server%\!character!\SavedVariables"

            :: Links erzeugen (nur wenn Quelle existiert)
            call :safe_link "%dest%!account!\macros-cache.txt" "%target%macros-cache.txt"
            call :safe_link "%dest%!account!\bindings-cache.wtf" "%target%bindings-cache.wtf"

            call :safe_link "%dest%!account!\SavedVariables\pfUI.lua" "%target%SavedVariables\pfUI.lua"
            call :safe_link "%dest%!account!\SavedVariables\Bagshui.lua" "%target%SavedVariables\Bagshui.lua"
            call :safe_link "%dest%!account!\SavedVariables\BigWigs.lua" "%target%SavedVariables\BigWigs.lua"
            call :safe_link "%dest%!account!\SavedVariables\Rinse.lua" "%target%SavedVariables\Rinse.lua"
            call :safe_link "%dest%!account!\SavedVariables\DPSMate.lua" "%target%SavedVariables\DPSMate.lua"
            call :safe_link "%dest%!account!\SavedVariables\ItemRack.lua" "%target%SavedVariables\ItemRack.lua"
            call :safe_link "%dest%!account!\SavedVariables\MikScrollingBattleText.lua" "%target%SavedVariables\MikScrollingBattleText.lua"
            call :safe_link "%dest%!account!\SavedVariables\Kui_Nameplates.lua" "%target%SavedVariables\Kui_Nameplates.lua"
           


            call :safe_link "%dest%!account!\%server%\!character!\camera-settings.txt" "%target%_Server\_Character\camera-settings.txt"
            call :safe_link "%dest%!account!\%server%\!character!\chat-cache.txt" "%target%_Server\_Character\chat-cache.txt"
            call :safe_link "%dest%!account!\%server%\!character!\layout-cache.txt" "%target%_Server\_Character\layout-cache.txt"

            call :safe_link "%dest%!account!\%server%\!character!\SavedVariables\TWThreat.lua" "%target%_Server\_Character\SavedVariables\TWThreat.lua"
            ::call :safe_link "%dest%!account!\%server%\!character!\SavedVariables\DPSMate.lua" "%target%_Server\_Character\SavedVariables\DPSMate.lua"
            call :safe_link "%dest%!account!\%server%\!character!\SavedVariables\pfQuest.lua" "%target%_Server\_Character\SavedVariables\pfQuest.lua"
            call :safe_link "%dest%!account!\%server%\!character!\SavedVariables\RollFor.lua" "%target%_Server\_Character\SavedVariables\RollFor.lua"
            call :safe_link "%dest%!account!\%server%\!character!\SavedVariables\SuperAPI.lua" "%target%_Server\_Character\SavedVariables\SuperAPI.lua"
            call :safe_link "%dest%!account!\%server%\!character!\SavedVariables\pfUI.lua" "%target%_Server\_Character\SavedVariables\pfUI.lua"

            
            ::nicht geteilte aber wichtige startdokumente
            copy "S:\Turlte-Wow\WTF\Account\_ALL\_Server\_Character\AddOns.txt" "%dest%!account!\%server%\!character!\AddOns.txt"

            echo.
        )
    )
)

pause
goto :eof

:: ===============================
:: Funktion: check_Folder
:: ===============================
:check_Folder
if not exist "%~1" (
    echo [+] Ordner wird angelegt: %~1
    mkdir "%~1"
) else (
    echo [=] Ordner existiert: %~1
)
goto :eof

:: ===============================
:: Funktion: safe_link
::  - prüft, ob Quelle existiert
::  - löscht Ziel falls vorhanden
::  - legt symbolischen Link an
:: ===============================
:safe_link
rem Parameter: %1 = Zielpfad, %2 = Quelldatei
if "%~1"=="" goto :eof
if "%~2"=="" goto :eof

if not exist "%~2" (
    ::echo     [!] Quelle existiert nicht: %~2 -- Link wird Uebersprungen.
    goto :eof
)

if exist "%~1" (
    ::echo     [-] Entferne vorhandene Datei/Link: %~1
    del "%~1" 2>nul
)

::echo     [+] Erstelle Link: %~1 --> %~2
mklink /h "%~1" "%~2"
goto :eof


::nicht geteilte aber wichtige Startdokumente
:copyTemplate
rem Parameter: %1=Quelldatei , %2= Zielpfad
if "%~1"=="" goto :eof
if "%~2"=="" goto :eof

if not exist "%~1" (
    ::echo     [!] Quelle existiert nicht: %~2 -- Link wird Uebersprungen.
    goto :eof
)

if exist "%~2" (
    ::echo     [-] Entferne vorhandene Datei/Link: %~1
    
)

copy "%~1" "%~2"

goto :eof