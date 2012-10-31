# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_05.rb

require File.dirname(__FILE__) +  "/rubykids"

  dach         = "/^\\" 
  erste_etage  = "|.|" 
  erdgeschoss  = "|_|" 

  anzahl_haeuser = 10
  platz_zwischen_haus = "   " 
  zaun                = ":::" 

  schreibe_leer
  # Alle Dächer in einer Zeile ausgeben:
  anzahl_haeuser.mal do
    schreib dach, platz_zwischen_haus
  end

  # Wir springen erst jetzt in die zweite Zeile!
  schreibe_leer 
  # Alle ersten Etagen in dieser Zeile:
  anzahl_haeuser.mal do
    schreib erste_etage, platz_zwischen_haus
  end

  # Und noch die dritte Zeile!
  schreibe_leer
  # Nun noch alle Erdgeschosse mit Zaun:
  anzahl_haeuser.mal do
    schreib erdgeschoss, zaun
  end

  schreibe_leer
