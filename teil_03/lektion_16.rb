# lektion_16.rb

# Definition der Klasse 'Haus'
class Haus
  def initialize(f, fd)
    @farbe      = f
    @farbe_dach = fd
  end
  def to_s
    "Haus[farbe=#{@farbe}, farbe_dach=#{@farbe_dach}]"
  end
end

# Anlegen von zwei Objekten der Klasse 'Haus'
h1 = Haus.new("gelb",  "rot")
h2 = Haus.new("braun", "rot")

puts h1.to_s
puts h2.to_s
