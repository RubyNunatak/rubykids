# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# theorie_07.rb

# Klasse Tür
class Tuer
  attr_reader :farbe, :material, :zustand
  attr_writer                    :zustand

  def initialize(farbe, material)
    @farbe = farbe
    @material = material
    @zustand = :geschlossen
  end

  def to_s
    "Tuer[zustand=#{@zustand}, farbe=#{@farbe}, material=#{@material}]"
  end
end

# Klasse Fenster
class Fenster
  attr_reader :farbe, :material, :zustand
  attr_writer                    :zustand

  def initialize(farbe, material)
    @farbe = farbe
    @material = material
    @zustand = :geschlossen
  end

  def to_s
    "Fenster[zustand=#{@zustand}, farbe=#{@farbe}, material=#{@material}]"
  end
end

# Klasse für Kachelofen
class Kachelofen
  attr_reader :farbe, :zustand
  attr_writer         :zustand

  def initialize(farbe = "gelb")
    @farbe = farbe
    @zustand = :aus
  end

  def to_s
    "Kachelofen[zustand=#{@zustand}, farbe=#{@farbe}]"
  end
end


# Klasse Wohnhaus
class Wohnhaus
  attr_accessor :farbe, :farbe_dach, :kachelofen, :tuer, :fenster

  def initialize(farbe, farbe_dach)
    @farbe      = farbe
    @farbe_dach = farbe_dach
    @kachelofen = Kachelofen.new
    @schornstein = :aus
    @tuer       = Tuer.new("schwarz", :holz)
    f = Fenster.new("braun", :holz)
    @fenster    = [f, f, f]
  end

  # Attribut kachelofen auslesen, dabei gegen Änderung schützen, indem
  # nur eine Kopie nach außen gegeben wird.
  def kachelofen
    Kachelofen.new(@kachelofen.farbe)
  end

  def tuer_auf
    @tuer.zustand = :offen
  end

  def tuer_zu
    @tuer.zustand = :geschlossen
  end

  def fenster_auf
    for f in @fenster
      f.zustand = :offen
    end
  end

  def fenster_zu
    for f in @fenster
      f.zustand = :geschlossen
    end
  end

  def ofen_an
    @kachelofen.zustand = :an
    @schornstein        = :raucht
  end

  def ofen_aus
    @kachelofen.zustand = :aus
    @schornstein        = :aus
  end

  def to_s
    res = "Wohnhaus[\n"
    res << "  farbe       = " + @farbe + "\n"
    res << "  dach        = " + @farbe_dach + "\n"
    res << "  kachelofen  = " + @kachelofen.to_s + "\n"
    res << "  tuer        = " + @tuer.to_s + "\n"
    res << "  schornstein = " + @schornstein.to_s + "\n"
    res << "  fenster     = " + "\n"
    for f in @fenster
      res << "    " + f.to_s + "\n"
    end
    res << "\n"
    res << "]"
    
    res
  end
end


w = Wohnhaus.new("gelb", "rot")
w.tuer = Tuer.new("blau", :holz)
w.kachelofen = Kachelofen.new("braun")
# Ein weiteres Fenster einbauen
w.fenster << Fenster.new("weiss", :kunststoff)
puts w

w.tuer_auf
w.fenster_auf
puts w

w.ofen_an
w.tuer_zu
w.fenster_zu
puts w
