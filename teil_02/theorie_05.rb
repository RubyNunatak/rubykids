# encoding: utf-8
# Copyright (C) 2007-2013 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_05.rb
require 'pp'

# Ein paar Listen anlegen
zahlen_liste = [2, 4, 6, 8, 10]

planeten_liste = 
[
  "Merkur",  "Venus", 
  "Erde",    "Mars", 
  "Jupiter", "Saturn", 
  "Uranus", "Neptun", 
]

irgendwas_liste = ["Mars", 95, "95", "Quark"]

leere_liste = []

# Einzelne Einkaufslisten
tegut = ["Butter", "Milch", "Honig", "Brot"]
obi   = ["Schrauben", "Leimholz", "Kabel", "Lampe"]
dm    = ["Duschbad für Mama",    "Deo für Papa", 
         "Haarspange für Livia", "Zahnbürste für Peter"]

# Gesamte Einkaufsliste, enthält die einzelnen Listen
einkauf = [tegut, obi, dm]

# Normale Ausgabe
puts einkauf

# Schickere Ausgabe mit pretty print
pp einkauf

# Ausgabe des dritten Elementes der Liste
pp einkauf[2]


# Hashtabellen
deutsch_spanisch = {
  1        => "uno",
  "eins"   => "uno",
  2        => "dos",
  "zwei"   => "dos",
  3        => "tres",
  "drei"   => "tres",
  4        => "cuatro",
  "vier"   => "cuatro",
  5        => "cinco", 
  "fuenf"  => "cinco", 
  6        => "seis",
  "sechs"  => "seis",
  7        => "siete",
  "sieben" => "siete",
  8        => "ocho",
  "acht"   => "ocho",
  9        => "nueve",
  "neun"   => "nueve",
  10       => "diez",
  "zehn"   => "diez",
}
pp deutsch_spanisch
puts "Vier heisst auf Spanisch #{deutsch_spanisch['vier']}."
puts "Acht heisst auf Spanisch #{deutsch_spanisch[8]}."

ds = deutsch_spanisch

deutsch_spanisch = {
  8        => "ocho",
  8        => "otscho",
}
puts "Acht heisst auf Spanisch #{deutsch_spanisch[8]}."

for planet in planeten_liste
  if planet.include?("e")
    puts planet
  end
end


de_esp = {
  "eins"   => "uno",
  "zwei"   => "dos",
  "drei"   => "tres",
  "vier"   => "cuatro",
  "fuenf"  => "cinco", 
  "sechs"  => "seis",
  "sieben" => "siete",
  "acht"   => "ocho",
  "neun"   => "nueve",
  "zehn"   => "diez",
}

for key in de_esp.keys
  if de_esp[key].include?("t")
    puts de_esp[key]
  end
end



