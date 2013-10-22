# encoding: utf-8
# Copyright (C) 2007-2013 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_06_a.rb 
liste = ["Auto", "Haus", "Baum", "Ball", "Buch", "Bett", "PC"]

kleiderhaken = {
  "Ball"   => "Susi",
  "Baum"   => "Livia",
  "Haus"   => "Petra",
  "Schiff" => "Rainer",
  "Auto"   => "Peter",
}

# ------------------------------------------------------------

kette = ["Auto", "Haus", "Baum"]
haken = {
  "Auto" => "Peter",
  "Haus" => "Petra",
  "Baum" => "Livia",
}

puts "Das zweite Element der Liste ist " + kette[1]

puts "Das zweite Element im Hash ist " + (haken[1] || "nil")

puts "Der Wert zum Schlüssel 'Haus' im Hash ist " + haken["Haus"]

def suche_in_liste_nach(wo, was)
  gefunden = false
  for element in wo do
    if element == was 
      gefunden = true
      break
    end
  end

  if gefunden
    puts "'" + was + "' ist drin!" 
  else
    puts "'" + was + "' ist NICHT drin!" 
  end
end

suche_in_liste_nach(kette, "Tisch")

suche_nach = "Tisch" 
if haken[suche_nach] != nil
  puts "Den Schlüssel '" + suche_nach + "' gibt es!" 
else
  puts "Den Schlüssel '" + suche_nach + "' gibt es nicht!" 
end

suche_in_liste_nach(haken.values, "Livia")

kette << "Tisch" 
suche_in_liste_nach(kette, "Tisch")

kette.delete "Tisch" 
suche_in_liste_nach(kette, "Tisch")

haken["Tisch"] = "Hans" 

haken.delete "Tisch"
  


 
