# encoding: utf-8
# Copyright (C) 2007-2013 www.rubykids.de Frithjof Eckhardt
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

# Bestimmt aus der Nummer eines Feldes die Spalte und Zeile
# Angenommen Spalte und Zeilen würden von 0 bis 2 gezählt werden.
# Dann ergeben sich folgende Formeln:

# Spalte, Zeile => Nummer => Formel
# ----------------------------------------
# 0,0           => 1      => 0*1 + 0*3 + 1
# 1,0           => 2      => 1*1 + 0*3 + 1
# 2,0           => 3      => 2*1 + 0*3 + 1
# 0,1           => 4      => 0*1 + 1*3 + 1
# 1,1           => 5      => 1*1 + 1*3 + 1
# 2,1           => 6      => 2*1 + 1*3 + 1
# 0,2           => 7      => 0*1 + 2*3 + 1
# 1,2           => 8      => 1*1 + 2*3 + 1
# 2,2           => 9      => 2*1 + 2*3 + 1
def nummer_in_spalte_zeile(num)
  spalte = ((num-1) % 3)
  zeile = (((num + 2 ) / 3 ) - 1)
  [spalte+1, zeile+1]
end

# Berechnet die Feldnummer aus gegebener Spalte und Zeile
# Tabelle für Zuordnung siehe oben bei Methode nummer_in_spalte_zeile.
def nummer_aus_spalte_zeile(spalte, zeile)
  nummer = 0
  nummer = (spalte-1)*1 + (zeile-1)*3 + 1 unless (spalte.nil? or zeile.nil?)
  nummer
end

# Stellt fest, ob es einen Gewinner gibt
def the_winner_is(zuege)
  reihen = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],

    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],

    [1, 5, 9],
    [3, 5, 7],
  ]


  # Variable für den Gewinner
  the_winner = nil

  # Für beide Spieler testen
  for spieler in [:o, :x]
    felder_besetzt = []

    for zug in zuege
      if zug[0] == spieler
        feld = nummer_aus_spalte_zeile(zug[1], zug[2])
        felder_besetzt << feld
      end
    end

    # In felder_besetzt stehen die Felder, die vom aktuellen Spieler 
    # belegt sind. Die können wir nun für alle Reihen testen.
    for reihe in reihen
      gewonnen = true
      for feld in reihe
        # gewonnen wird falsch (false), wenn das aktuelle Feld der 
        # Reihe nicht besetzt ist.
        gewonnen = (gewonnen and felder_besetzt.include?(feld))
        break if gewonnen == false # in der Reihe kein Gewinn mehr 
      end
      if gewonnen
        the_winner = spieler
        break # Gewinner gefunden, aufhören weiter zu suchen
      end
    end

    # Wenn es einen Gewinner gibt, für den nächsten gar nicht erst 
    # mehr versuchen, denn dieser kann nicht auch gleichzeitig 
    # gewonnen haben, das hätten wir beim vorherigen Zug bereits 
    # bemerkt.
    break if the_winner != nil
  end

  the_winner
end


# Schaut nach, ob das Spiel schon aus ist
def ist_beendet?(zuege)
  alle_zuege_gemacht = zuege.nil? ? false : zuege.size >= 9
  gewinner = the_winner_is(zuege)
  # Zwei Rückgabewerte in einer Liste:
  # Erster Wert: gibt an (true, false), ob das Spiel aus ist
  # Zweiter Wert: der Gewinner (oder nil, falls es keinen gibt)
  [(alle_zuege_gemacht or (gewinner != nil)), gewinner]
end

# Lässt 2 Spieler miteinander spielen
def play_2_spieler(out, ein, zuege)
  spieler = [[:o, 'O'], [:x, 'X']]
  wer = 0
  ergebnis = [false, nil]
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
    ergebnis = ist_beendet?(zuege)
    beendet = ergebnis[0]
    break if (beendet or !zug_okay)
    wer += 1
    wer %= 2
  end
  # Rückgabewerte: der aktuelle Spieler, falls er der Gewinner ist.
  gewinner = ergebnis[1]
  if gewinner != nil
    return spieler[wer]
  else
    return nil
  end
end

def zufalls_zug(zuege, wer)
  frei = freie_felder(zuege)
  zug = [wer, 0, 0]
  if frei.size > 0
    jetzt = Time.now
    sekunden = jetzt.sec
    index = sekunden % frei.size
    spalte, zeile = nummer_in_spalte_zeile(frei[index])
    zug = [wer, spalte, zeile]
  end
  zug
end

def naiver_zug(zuege, wer)
  frei = freie_felder(zuege)
  zug = nil
  if frei.size > 0
    # Nehme das erste freie Feld
    spalte, zeile = nummer_in_spalte_zeile(frei[0])
    zug = [wer, spalte, zeile]
  end
  zug
end

def freie_felder(zuege)
  frei = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  for zug in zuege
    nummer = nummer_aus_spalte_zeile(zug[1], zug[2])
    frei.delete(nummer)
  end
  frei
end


def computer_zug(zuege, wer)
  #naiver_zug(zuege, wer)
  zufalls_zug(zuege, wer)
end

# Lässt 1 Spieler gegen den Computer spielen
def play_gegen_computer(out, ein, zuege)
  spieler = [[:o, 'O'], [:x, 'X']]
  ergebnis = [false, nil]

  wer = nil
  out.print "Was spielst du, X oder O? "
  eingabe = ein.gets.downcase.chomp
  wer = (eingabe == 'x') ? 1 : 0

  out.puts "Los geht's! Du spielst #{spieler[wer][1]}, und ich #{spieler[1^wer][1]}!"
  out.puts "Du fängst an."

  while true
    # Der menschliche Spieler zuerst
    zug_okay = false
    until zug_okay
      out.print "#{spieler[wer][1]} ist am Zug: "
      nummer = ein.gets.to_i
      break if nummer == 0
      spalte, zeile = nummer_in_spalte_zeile(nummer)
      zug_okay = zug_hinzu(spieler[wer][0], spalte, zeile, zuege)
    end
    spielfeld(out, zuege)
    ergebnis = ist_beendet?(zuege)
    beendet = ergebnis[0]
    break if (beendet or !zug_okay)
    wer += 1
    wer %= 2

    # Gleich den Zug des Computers anschließen
    zug_okay = false
    until zug_okay
      out.puts "\nJetzt bin ich dran!"
      zug = computer_zug(zuege, wer)
      out.puts "Ich setze auf das Feld #{nummer_aus_spalte_zeile(zug[1], zug[2])}."
      break if zug.nil?
      zug_okay = zug_hinzu(spieler[wer][0], zug[1], zug[2], zuege)
    end
    spielfeld(out, zuege)
    ergebnis = ist_beendet?(zuege)
    beendet = ergebnis[0]
    break if (beendet or !zug_okay)
    wer += 1
    wer %= 2
  end
  # Rückgabewerte: der aktuelle Spieler, falls er der Gewinner ist.
  gewinner = ergebnis[1]
  if gewinner != nil
    return spieler[wer]
  else
    return nil
  end
end

