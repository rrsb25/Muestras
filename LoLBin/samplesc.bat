
@echo off
setlocal enabledelayedexpansion

:: ----------------------------------------------------
:: Nombre del archivo de salida
:: Se usará el formato "informe_AAAA-MM-DD_HH-MM-SS.txt"
:: ----------------------------------------------------
for /f "tokens=2,3,4 delims=/ " %%a in ('date /t') do (set date_str=%%c-%%a-%%b)
for /f "tokens=1" %%a in ('time /t') do (
    set time_str=%%a
    set time_str=!time_str::=-!
    set time_str=!time_str: =!
)
set output_file="informe_%date_str%_%time_str%.txt"

echo Generando informe...
echo.

:: ----------------------------------------------------
:: 1. Saludo Inicial
:: ----------------------------------------------------
echo ========================================================== > %output_file%
echo                      HOLA WORLD                            >> %output_file%
echo ========================================================== >> %output_file%
echo. >> %output_file%

:: ----------------------------------------------------
:: 2. Identificar el usuario y sus permisos
:: ----------------------------------------------------
echo # Información del Usuario y Permisos >> %output_file%
echo --------------------------------------- >> %output_file%

:: Nombre de Usuario
echo Usuario Ejecutor: %USERNAME% >> %output_file%

:: Identificar si es administrador (Intento simple, no infalible)
:: El comando "net session" solo se ejecuta correctamente con permisos elevados.
net session >nul 2>&1
if %errorlevel% equ 0 (
    echo Permisos: ADMINISTRADOR (Elevados) >> %output_file%
) else (
    echo Permisos: USUARIO ESTÁNDAR (No elevados) >> %output_file%
)
echo. >> %output_file%

:: ----------------------------------------------------
:: 3. Datos Relevantes del Sistema
:: ----------------------------------------------------
echo # Datos Relevantes del Sistema >> %output_file%
echo ---------------------------------- >> %output_file%

:: Información del Sistema Operativo
systeminfo | findstr /B /C:"Nombre del SO" /C:"Versi" /C:"Arquitectura del sistema" /C:"ID del producto" /C:"Tipo de sistema" >> %output_file%
echo. >> %output_file%

:: Información de la Red
echo ** Configuración de Red (IP, DNS, Puerta de Enlace) ** >> %output_file%
ipconfig /all | findstr /C:"Direcci.n IPv4" /C:"Puerta de enlace predeterminada" /C:"Servidores DNS" /C:"Nombre de host" >> %output_file%
echo. >> %output_file%

:: Estado de la Memoria (Opcional, puede ser extenso)
echo ** Estado de la Memoria ** >> %output_file%
wmic ComputerSystem get TotalVisibleMemorySize /value | findstr "TotalVisibleMemorySize" >> %output_file%
wmic OS get FreePhysicalMemory /value | findstr "FreePhysicalMemory" >> %output_file%
echo. >> %output_file%

:: Mostrar la ubicación donde se guardó el archivo
echo.
echo ==========================================================
echo ✅ Proceso terminado.
echo La información ha sido guardada en:
echo %CD%\%output_file%
echo ==========================================================

endlocal
pause
