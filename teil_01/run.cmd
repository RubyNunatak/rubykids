@echo off
rem Copyright (C) 2007-2013 www.rubykids.de Frithjof Eckhardt
rem Alle Rechte vorbehalten.

if "%1"=="" goto usage
SET LEKTION_PREFIX=lektion_
SET LEKTION_NR=%1

rem UTF-8 Codepage
set UTF8CP=65001

setlocal EnableExtensions
setlocal EnableDelayedExpansion

rem Alte Codepage merken
set CP_OLD=
for /f "tokens=1 delims==" %%i in ('chcp') do (
  set CP_OLD=%%i
  set CP_OLD=!CP_OLD:Aktive Codepage:=!
  set CP_OLD=!CP_OLD:~1,-1!
)

rem UTF-8 Codepage für Ausgabe setzen
chcp %UTF8CP% > nul

rem Gewünschte Lektion mit Ruby-Interpreter aufrufen
ruby %LEKTION_PREFIX%%LEKTION_NR%.rb

chcp %CP_OLD% > nul
rem ... und wieder auf vorherige Codepage einstellen

endlocal
goto end

:usage
echo.Ruft den Rubyinterpreter fuer eine Lektion auf (www.rubykids.de).
echo.
echo run nn
echo  nn - die Nummer einer Lektion
echo.
echo Beispiele: 
set example1=01
set example2=07
echo.
echo   run %example1%
echo   run %example2%
echo.
echo Ruft die Lektionen %example1%, oder %example2% auf und entspricht den Befehlen: 
echo.
echo   ruby %LEKTION_PREFIX%%example1%.rb
echo   ruby %LEKTION_PREFIX%%example2%.rb
echo.

:end
