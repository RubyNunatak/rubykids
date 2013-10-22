# encoding: utf-8
# Copyright (C) 2007-2013 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_04.rb

def kaffee_maschine(wasser, filter, pulver)
  # Die Maschine beginnt mit dem Heizen des Wassers
  puts "=> #{wasser} Wasser werden heisser und heisser..." 
  puts "=> Pumpe das Wasser durch ein Roehrensystem..." 
  puts "=> Und lasse es auf #{pulver} Pulver in den #{filter} fallen.\n" 
  # Das heisse Wasser laeuft durch das Pulver im Filter in die Glaskanne
  # darunter, das geht von alleine, da braucht die Maschine nichts 
  # weiter zu machen 
  # ...
  # Maschine ist fertig:
  puts "=> Fauchen und Dampf ablassen als Zeichen, dass ich fertig bin..." 

  # Fertigen Kaffee zurueckliefern
  return "Bitte schön: Glaskanne mit #{wasser} leckerem Kaffee" 
end

wasser = "2 Tassen (okay Papa kriegt auch eine)" 
filter = "Kaffeefilter Groesse 4 (der aus dem Aldi)" 
pulver = "Mhhmm, riecht das lecker. 2 Löffel!" 

kaffee_fuer_mama = kaffee_maschine(wasser, filter, pulver)

puts "Kaffee ist fertig!" 
puts kaffee_fuer_mama
