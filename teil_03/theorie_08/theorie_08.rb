# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_08.rb
#
# Rekursion
#
parameter = ARGV[0]
if parameter.nil?
  # Ohne Parameter mach ich gar nix
  puts "Parameter fehlt!"
  exit
else
  parameter = parameter.to_i - 1
end

# Abbrechen, wenn parameter den Wert 0 unterschreitet
if parameter < 0
  exit
end

# Ansonsten dann die eigentliche Arbeit verrichten
puts "Das #{parameter}. Hallo aus der Rekursion!"

# Und schließlich sich selbst aufrufen
system("ruby " + __FILE__ + " " + parameter.to_s)
