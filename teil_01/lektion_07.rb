# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_07.rb
# *** Diese Lektion funktioniert leider in Eclipse nicht 
# *** Führe dieses Programm direkt 
#     o entweder in einem DOS-Fenster aus, wenn Du mit 
#       Microsoft Windows arbeitest, mit:
#         c:\entwicklung> ruby lektion_07.rb
#     o oder in einem Terminal Fenster, wenn Du mit Linux arbeitest, mit:
#         deinname@deincomputer:~/entwicklung$ ruby lektion_07.rb

require File.dirname(__FILE__) +  "/rubykids"

# Variable für das Fahrzeug, hier ein Fahrrad (etwas Phantasie bitte!)
fahrzeug       = "o^o" 

# Variable für die Länge der Straße
strassen_laenge = 60

# Variable für die rechte Stelle, bis zu der das Fahrzeug nur fahren darf.
# Wir wollen es nämlich nicht über den Rand herausfahren lassen.
fahrzeug_ende_rechts = strassen_laenge - fahrzeug.laenge + 1

# *** 1. Häuserreihe malen
dach         = "/^\\" 
erste_etage  = "|.|" 
erdgeschoss  = "|_|" 

anzahl_haeuser = 10
platz_zwischen_haus = "   " 
zaun                = ":::" 

schreibe_leer
# Alle Dächer in einer Zeile ausgeben
anzahl_haeuser.mal do
  schreib dach, platz_zwischen_haus
end

# wir springen erst jetzt in die zweite Zeile!
schreibe_leer 
# Alle ersten Etagen in der nächsten Zeile
anzahl_haeuser.mal do
  schreib erste_etage, platz_zwischen_haus
end

# und noch die dritte Zeile!
schreibe_leer
# Nun noch alle Erdgeschosse mit Zaun
anzahl_haeuser.mal do
  schreib erdgeschoss, zaun
end

schreibe_leer

# *** 2. Strasse von links nach rechts malen
# Oberer Rand:
strassen_laenge.mal { schreib "_" }
schreibe_leer
# Der Mittelstreifen:
strassen_laenge.mal { schreib "." }
schreibe_leer
# Und noch den unteren Rand, hier führt dann das Fahrzeug
strassen_laenge.mal { schreib "_" }

# Variable für die aktuelle Stelle des Fahrzeuges
stelle = 0

# Variable für den Wert der Taste, die gedrückt wird
taste  = "" 

# *** 3. In einer Schleife wiederholt das Zeichen von der Tastatur
# lesen und nur die Zeile mit dem Fahrzeug neu malen. Der Rest 
# darüber bleibt wie er war.
while taste = lies_ein_zeichen
  # Wenn L-Taste gedrückt, dann das Fahrzeug nach links bewegen
  stelle = stelle - 1 if taste == "l" 

  # Wenn R-Taste gedrückt, dann das Fahrzeug nach rechts bewegen
  stelle = stelle + 1 if taste == "r" 

  # While-Schleife verlassen, wenn X-Taste gedrückt
  exit if taste.buchstaben_klein == "x" 

  # Falls das Fahrzeug nach links aus dem Fenster herausfahren will,
  # wieder auf die Anfangsstelle ganz links stellen
  if stelle < 1 then stelle = 1 end

  # Falls das Fahrzeug nach rechts weiter fahren will, als die Strasse
  # lang ist, auf die rechteste Endestelle stellen
  if stelle > fahrzeug_ende_rechts then stelle = fahrzeug_ende_rechts end

  # Zeile löschen, d.h. wieder vorne mit der Ausgabe anfangen 
  schreib "\r" 

  # Den Teil der Strasse vor dem Fahrzeug ausgeben
  (stelle-1).mal { schreib "_" }

  # Das Fahrzeug selbst ausgeben
  schreib fahrzeug

  # Den Teil der Strasse nach dem Fahrzeug ausgeben
  (fahrzeug_ende_rechts-stelle).mal { schreib "_" }
end
