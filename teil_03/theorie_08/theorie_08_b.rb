# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_08_b.rb

def sag_was(counter, start = nil)
  if start.nil? then start = counter end
  if counter.nil?
    # Ohne Parameter mach ich gar nix
    puts "Parameter fehlt!" 
    return
  else
    counter = counter - 1
  end
 
  # Abbrechen, wenn counter den Wert 0 unterschreitet
  if counter < 0
    return
  end
 
  # Ansonsten dann die eigentliche Arbeit verrichten
  puts "Das #{start - (counter % start)}. Hallo aus der Rekursion!" 
 
  # Und schließlich sich selbst aufrufen
  sag_was(counter, start)
end
 
# Erster Aufruf immer von außen
sag_was(ARGV[0].to_i)

