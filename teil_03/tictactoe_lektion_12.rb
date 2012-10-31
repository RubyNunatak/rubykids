# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# tictactoe.rb

# Methode, die das Spielfeld im Ausgabebereich 'out' ausgibt
# und dabei auch die in 'zuege' angegebenen Züge mit ausgibt.
# Ist für ein Feld noch kein Zug erfolgt, dann wird die
# Nummer des Feldes ausgegeben. Die Felder sind dabei von
# links nach rechts und oben nach unten von 1 bis 9 fortlaufend
# nummeriert.
def spielfeld(out, zuege)
  out.puts  "/-----------\\" 
  out.print "| " 

  print_zeile(out, 1, zuege)

  out.puts " |" 
  out.puts  "|---|---|---|" 
  out.print "| " 

  print_zeile(out, 2, zuege)

  out.puts " |" 
  out.puts  "|---|---|---|" 
  out.print "| " 

  print_zeile(out, 3, zuege)

  out.puts " |" 
  out.puts "\\-----------/" 
end

# Methode zum Ausgeben einer einzigen Zeile im Ausgabebereich 'out'.
# Welche Zeile ausgegeben werden soll ist in 'zeile' übergeben.
# Die Liste der Züge in 'zuege' brauchen wir hier, um das richtige
# Symbol (X oder O) später in den Feldern ausgeben zu können, 
# oder die Nummer des Feldes.
def print_zeile(out, zeile, zuege)
  spalte = 1
  1.upto(3) do 
    print_feld(spalte, zeile, zuege)
    out.print " | " unless spalte == 3
    spalte += 1
  end
end

# Methode, die ein bestimmtes Feld ausgibt. Entweder wird
# das Symbol für den Spieler ausgegeben, der das Feld besetzt hat,
# oder es wird die laufende Nummer des Feldes ausgegeben.
def print_feld(spalte, zeile, zuege)
  res = (spalte-1)*1 + (zeile-1)*3 + 1
  for z in zuege do
    if z[1] == spalte and z[2] == zeile
      res = (z[0] == :x ? "X" : "O") 
      break
    end
  end
  print res
end

# Methode zum Hinzufügen eines Zuges.
def zug_hinzu(wer, spalte, zeile, zuege)
  # Nicht erlauben, wenn das Feld schon besetzt ist
  erlaubt = true
  zuege.each do |zug|
    if zug[1] == spalte and zug[2] == zeile
      # Einen Zug für diese Feld gibt es schon
      erlaubt = false
      break
    end
  end
  # Ein Zug besteht aus einer kleinen Liste mit genau 3 Elementen:
  # 1. Element 'wer': gibt den Spieler an, entweder :x oder :o
  # 2. Element 'spalte': die Spalte, in der der Zug gesetzt werden soll
  # 3. Element 'zeile': die Zeile, in die der Zug gesetzt werden soll
  zuege << [wer, spalte, zeile] if erlaubt
  erlaubt
end

# Berechnete die spalte und zeile für die Nummer eines Feldes
def nummer_in_spalte_zeile(num)
  spalte = ((num-1) % 3)
  zeile = (((num + 2 ) / 3 ) - 1)
  [spalte+1, zeile+1]
end

# Schaut nach, ob das Spiel schon aus ist
def ist_beendet?(zuege)
  zuege == nil ? false : zuege.size >= 9
end

# Lässt 2 Spieler miteinander spielen
def play_2_spieler(out, ein, zuege)
  spieler = [[:o, 'O'], [:x, 'X']]
  wer = 0
  while true
    zug_okay = false
    until zug_okay
      out.print "#{spieler[wer][1]} ist am Zug: "
      nummer = ein.gets.to_i
      break if nummer == 0
      spalte, zeile = nummer_in_spalte_zeile(nummer)
      zug_okay = zug_hinzu(spieler[wer][0], spalte, zeile, zuege)
    end
    spielfeld(out, zuege)
    break if ist_beendet?(zuege) or !zug_okay
    wer += 1
    wer %= 2
  end
  spieler[wer]
end

