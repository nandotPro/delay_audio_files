@echo off
setlocal enabledelayedexpansion

set /p SECONDS=Quantos segundos de silêncio deseja adicionar no final dos arquivos? 

:ask_input
set /p INPUT=Qual a pasta de entrada:
set INPUT_PATH=%cd%\%INPUT%

if not exist "%INPUT_PATH%" (
    echo.
    echo [ERRO] A pasta "%INPUT%" nao existe em %cd%
    echo.
    goto ask_input
)

REM Output dir = entrada_new e entrada_wav
set OUTPUT=%cd%\%INPUT%_new
set WAV_OUTPUT=%cd%\%INPUT%_wav

if exist "%OUTPUT%" (
    echo Limpando pasta antiga: %OUTPUT%
    rmdir /s /q "%OUTPUT%"
)
mkdir "%OUTPUT%"

if exist "%WAV_OUTPUT%" (
    echo Limpando pasta antiga: %WAV_OUTPUT%
    rmdir /s /q "%WAV_OUTPUT%"
)
mkdir "%WAV_OUTPUT%"

echo =========================================
echo  Modificando todos os arquivos .sln .sln16 .wav .gsm
echo  Pasta origem : %INPUT_PATH%
echo  Pasta destino: %OUTPUT%
echo =========================================
echo.

REM Loop 
for /r "%INPUT_PATH%" %%f in (*.sln *.sln16 *.wav *.gsm) do (
    set "SRC=%%f"
    set "REL=%%f"
    set "REL=!REL:%INPUT_PATH%=!"
    set "DEST=%OUTPUT%!REL!"
    set "DEST_WAV=%WAV_OUTPUT%!REL!"
    set "DEST_WAV=!DEST_WAV:~0,-4!.wav"

    REM Garante as pastas destino
    for %%D in ("!DEST!") do if not exist "%%~dpD" mkdir "%%~dpD"
    for %%D in ("!DEST_WAV!") do if not exist "%%~dpD" mkdir "%%~dpD"

   echo Processando: %%~nxf

    if /I "%%~xf"==".sln" (
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" ^
        -t raw -r 8000 -e signed -b 16 -c 1 "%%f" ^
        -t raw -r 8000 -e signed -b 16 -c 1 "!DEST!" ^
        pad 0 %SECONDS%
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" ^
        -t raw -r 8000 -e signed -b 16 -c 1 "!DEST!" "!DEST_WAV!" pad 0 0

) else if /I "%%~xf"==".sln16" (
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" ^
        -t raw -r 16000 -e signed -b 16 -c 1 "%%f" ^
        -t raw -r 16000 -e signed -b 16 -c 1 "!DEST!" ^
        pad 0 %SECONDS%
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" ^
        -t raw -r 16000 -e signed -b 16 -c 1 "!DEST!" "!DEST_WAV!" pad 0 0

) else if /I "%%~xf"==".wav" (
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" "%%f" "!DEST!" pad 0 %SECONDS%
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" "!DEST!" "!DEST_WAV!" pad 0 0

) else if /I "%%~xf"==".gsm" (
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" "%%f" "!DEST!" pad 0 %SECONDS%
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" "!DEST!" "!DEST_WAV!" pad 0 0
)

)

echo.
echo ==== Finalizado! ====
echo Arquivos modificados estao em: %OUTPUT%
echo Versoes em WAV para teste estao em: %WAV_OUTPUT%
pause
