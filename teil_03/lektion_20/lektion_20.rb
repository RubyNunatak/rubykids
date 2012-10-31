# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_20.rb
#
puts "Schreibe Datei..."

File.open("c:/herbarium/convolvulus_arvensis.txt", "w") do |datei|
  datei.puts "Convolvulus arvensis L."
  datei.puts "Familie: Convolvulaceae"
  datei.puts "Ordnung: Solanales"
  datei.puts "Deutscher Name: Acker-Winde"
  datei.puts "Blütenfarbe: weiß bis rosa oder gestreift"
  datei.puts "Blüten: blattachselständig, lang gestielt, Krone weit trichterförmig, 2-3 cm lang"
  datei.puts "Blätter: pfeil-/spießförmig, 3-4 cm lang"
  datei.puts "Stängel: dünn, kriechend, windend"
  datei.puts "Wurzel: bis 2 m tief"
  datei.puts "Vorkommen: Äcker, Weinberge, Gärten, Wegränder"
end

puts "Lese gesamte Datei..."

File.open("c:/herbarium/convolvulus_arvensis.txt", "r") do |datei|
  puts datei.read
end

puts "Lese zeilenweise..."

File.open("c:/herbarium/convolvulus_arvensis.txt", "r") do |datei|
  datei.each do |zeile|
    puts zeile
  end
end

puts "Verschiedene Codierungen..."

File.open("c:/herbarium/convolvulus_arvensis.txt", "rb") do |file|
  puts "\tDez\tHex\tOkt\tBin"
  puts "\t---\t---\t---\t---"
  while(b = file.getc)
    c = b.chr
    puts "#{Regexp.escape(c)},\t#{b},\t0x#{b.to_s(16).upcase},\to#{b.to_s(8).upcase},\t#{b.to_s(2)}"
  end
end

