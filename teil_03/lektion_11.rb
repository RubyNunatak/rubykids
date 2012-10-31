# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_11.rb

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
  # Ein Zug besteht aus einer kleinen Liste mit genau 3 Elementen:
  # 1. Element 'wer': gibt den Spieler an, entweder :x oder :o
  # 2. Element 'spalte': die Spalte, in der der Zug gesetzt werden soll
  # 3. Element 'zeile': die Zeile, in die der Zug gesetzt werden soll
  zuege << [wer, spalte, zeile]
end

# Variable für die Liste der Züge; Sie ist anfangs leer.
zuege = []

# Spielfeld auf der Standardausgabe einmal ausgeben.
spielfeld(STDOUT, zuege)

# Einen Zug zum Testen: O setzt oben links!
zug_hinzu(:o, 1, 1, zuege)

# Neues Spielfeld ausgeben
spielfeld(STDOUT, zuege)
