# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_08.rb
require File.dirname(__FILE__) +  "/rubykids"

maximum = 1000
summe = zahl = 0

maximum.mal do
  zahl = zahl + 1
  summe += zahl if (zahl.rest_bei_div(3) == 0 or zahl.rest_bei_div(5) == 0 and zahl < maximum)
end
schreibe "Die Summe aller Vielfache von 3 und 5 kleiner #{maximum} ist #{summe}." 
