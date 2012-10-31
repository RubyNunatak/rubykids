# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_19.rb

# Iterator einer Liste
eisenklumpen_container = ["klumpen1", "klumpen2", "klumpen3", "klumpen4"]

eisenklumpen_container.each do |klumpen|
  puts "Erhitze den #{klumpen}..."
  puts "Schlage den #{klumpen} auf dem Amboss..."
  puts "... zu geschmeidigem Stahl."
  puts
end

# bisher
for klumpen in eisenklumpen_container do 
  puts "Erhitze den #{klumpen}..."
  puts "Schlage den #{klumpen} auf dem Amboss..."
  puts "... zu geschmeidigem Stahl."
  puts
end

# Iteratoren beim Hash
deutsch_spanisch = {
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

deutsch_spanisch.each_key do |key|
  puts "Iterator bearbeitet gerade den Schluessel: #{key}"
end

deutsch_spanisch.each_value do |value|
  puts "Iterator bearbeitet gerade den Wert: #{value}"
end

deutsch_spanisch.each_pair do |key, value|
  puts "Iterator bearbeitet gerade das Paar: #{key}, #{value}"
end


# Einen eigenen Iterator erfinden
class MeineListe < Array
  def each_mit_nachfolger
    akt_nachfolger = nil
    akt_element    = nil
    each do |element|
      akt_element    = akt_nachfolger
      akt_nachfolger = element
      if akt_element != nil
        yield(akt_element, akt_nachfolger) if block_given?
      end
    end
  end
end

liste = MeineListe.new(["eins", "zwei", "drei", "vier"])

liste.each_mit_nachfolger do |element, nachfolger|
  puts "'#{element}' kommt in der Liste vor '#{nachfolger}'"
end

liste.each_mit_nachfolger





# Code-Blöcke als Konservendose

element    = nil
nachfolger = nil
ein_block = Proc.new {  puts "'#{element}' kommt in der Liste vor '#{nachfolger}'" }
liste.each_mit_nachfolger do |element, nachfolger|
  ein_block.call
end

puts element
puts nachfolger
ein_block.call


# Block als Closure verstehen
sag_hallo = nil

1.times do
  name = "Peter"
  sag_hallo = Proc.new {puts "Hallo #{name}!"}
  name = "Eulalia"
end

name = "Livia"

sag_hallo.call















