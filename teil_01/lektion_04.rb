# lektion_04.rb

require File.dirname(__FILE__) +  "/rubykids"

  schublade1           = "Hemden"
  anzahl_in_schublade1 = 5

  schublade2           = "Hosen"
  anzahl_in_schublade2 = 7

  die_kleine_schublade = "Socken"
  anzahl_in_kleinen    = 10

  RIESEN_SCHUBLADE     = "Mein Schrank"

  rot                  = "rot"
  text                 = " ist voll mit "

  # Einen Satz während der Ausgabe bilden

  schreib  RIESEN_SCHUBLADE, text
  schreib           anzahl_in_schublade1, " ", schublade1
  schreib  " und ", anzahl_in_schublade2, " ", schublade2
  schreibe " und #{anzahl_in_kleinen} ", rot, "en ", die_kleine_schublade

  # Denselben Satz zunächst in einer Variablen speichern
  # und erst danach ausgeben, diesmal noch einen Punkt anhängen.

  satz =  "#{RIESEN_SCHUBLADE}#{text}"
  satz << "#{anzahl_in_schublade1} #{schublade1}"
  satz << " und #{anzahl_in_schublade2} #{schublade2}"
  satz << " und #{anzahl_in_kleinen} #{rot}en #{die_kleine_schublade}"
  satz << "."

  schreibe satz
