# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_06_b.rb

# Pulloverfarbe mit zwei Listen

woche = ["Mo", "Di", "Mi", "Do", "Fr"]
farbe = ["gelb", "blau", "pink", "rot", "gr�n"]

tag_zaehler = 0
for tag in woche do
  puts "Am " + tag + " ist die Farbe " + farbe[tag_zaehler]
  tag_zaehler = tag_zaehler + 1
end

such_tag = "Mi" 
tag_zaehler = 0
for tag in woche do
  break if tag == such_tag
  tag_zaehler = tag_zaehler + 1
end

puts "Am " + such_tag + " ist die Farbe " + farbe[tag_zaehler] + "!"

# Pulloverfarbe mit einer Liste

pullover = ["Mo", "gelb", "Di", "blau", "Mi", "pink", "Do", "rot", "Fr", "gr�n"]

tag_zaehler = 0
1.upto(5) do
  tag   = pullover[tag_zaehler]
  farbe = pullover[tag_zaehler + 1]
  puts "Am " + tag + " ist die Farbe " + farbe
  tag_zaehler = tag_zaehler + 2
end


such_tag = "Mi" 
tag_zaehler = 0
1.upto(5) do
  break if pullover[tag_zaehler] == such_tag
  tag_zaehler = tag_zaehler + 2
end

puts "Am " + such_tag + " ist die Farbe " + pullover[tag_zaehler + 1] + "!" 


# Pulloverfarbe mit vielen Listen in einer Liste

pullover = [
  ["Mo", "gelb"], 
  ["Di", "blau"],
  ["Mi", "pink"],
  ["Do", "rot"],
  ["Fr", "gr�n"],
]
for paar in pullover do
  puts "Am " + paar[0] + " ist die Farbe " + paar[1]
end

such_tag = "Mi" 
for paar in pullover do
  if paar[0] == such_tag
    puts "Am " + such_tag + " ist die Farbe " + paar[1] + "!" 
    break
  end
end


# Pulloverfarbe mit Hash

pullover_hash = {
  "Mo" => "gelb",
  "Di" => "blau", 
  "Mi" => "pink", 
  "Do" => "rot",
  "Fr" => "gr�n",
}

for tag in pullover_hash.keys do 
  puts "Am " + tag + " ist die Farbe " + pullover_hash[tag]
end


such_tag = "Mi" 
puts "Am " + such_tag + " ist die Farbe " + pullover_hash[such_tag]




