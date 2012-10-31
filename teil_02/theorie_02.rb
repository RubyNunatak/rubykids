# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_02.rb

$stdout.sync = true

print "Gib eine Zahl a zwischen 1 und 100 ein! a=" 
a = gets
a = a.chomp
a = a.to_i

zahl_teilbar_durch_3 = false
if a % 3 == 0 
  zahl_teilbar_durch_3 = true
end

puts "Du hast a=#{a} eingegeben." 
if zahl_teilbar_durch_3
  puts "#{a} ist durch 3 teilbar." 
else
  puts "#{a} ist nicht durch 3 teilbar." 
end

$stdout.flush
a = gets
a = a.chomp
a = a.to_i

