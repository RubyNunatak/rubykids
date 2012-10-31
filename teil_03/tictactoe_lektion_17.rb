# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_17.rb

class Spieler
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    @name.to_s.upcase unless @name.nil?
  end
end

class Zug
  attr_reader :spieler, :nummer, :spalte, :zeile

  def initialize(spieler, nummer)
    @spieler = spieler
    @nummer  = nummer
    @spalte, @zeile = nummer_in_spalte_zeile(nummer)
  end

  def to_s
    "Zug[spieler=#{@spieler},nummer=#{@nummer},spalte=#{@spalte},zeile=#{@zeile}]"
  end

  private

  # Bestimmt aus der Nummer eines Feldes die Spalte und Zeile
  # Angenommen Spalte und Zeilen würden von 0 bis 2 gezählt werden.
  # Dann ergeben sich folgende Formeln:
  # 
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

end


class Spielfeld
  attr_accessor :feldnummerierung
  @@reihen = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],

    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],

    [1, 5, 9],
    [3, 5, 7],
  ]

  def initialize(feldnummerierung = false)
    @zuege = []
    @spieler_x = Spieler.new(:x)
    @spieler_o = Spieler.new(:o)
    @feldnummerierung = feldnummerierung
  end

  def spieler
    [@spieler_o, @spieler_x]
  end

  def zuege
    @zuege
  end

  # Methode zum Hinzufügen eines Zuges.
  def zug_hinzu(zug_neu)
    # Nicht erlauben, wenn das Feld schon besetzt ist
    erlaubt = true
    @zuege.each do |zug|
      if zug.nummer == zug_neu.nummer
        # Einen Zug für diese Feld gibt es schon
        erlaubt = false
        break
      end
    end
    @zuege << Zug.new(zug_neu.spieler, zug_neu.nummer) if erlaubt
    erlaubt
  end

  # Methode, die das Spielfeld im Ausgabebereich 'aus' ausgibt.
  # Ist für ein Feld noch kein Zug erfolgt, dann wird die
  # Nummer des Feldes ausgegeben. Die Felder sind dabei von
  # links nach rechts und oben nach unten von 1 bis 9 fortlaufend
  # nummeriert.
  def print(aus)
    aus.puts  "/-----------\\" 
    aus.print "| " 

    print_zeile(aus, 1)

    aus.puts " |" 
    aus.puts  "|---|---|---|" 
    aus.print "| " 

    print_zeile(aus, 2)

    aus.puts " |" 
    aus.puts  "|---|---|---|" 
    aus.print "| " 

    print_zeile(aus, 3)

    aus.puts " |" 
    aus.puts "\\-----------/" 
  end

  # Bestimmt den Status einer Reihe in der aktuellen Spielsituation. 
  # Rückgabewerte sind eine Liste der besetzten und der freien Felder.
  # Die Liste der besetzten Felder ist aufgeteilt nach Spielern und
  # in einem Hash nach folgender Form organisiert:
  #
  #  besetzt = {
  #    :o => Liste der von O besetzten Felder, 
  #    :x => Liste der von X besetzten Felder
  #  }
  #   
  def reihen_status(reihe)
    # Welche Felder sind noch frei?
    frei_alle = freie_felder
    frei = []
    for feld in reihe
      if frei_alle.include?(feld)
        frei << feld
      end
    end
    
    # Welche Felder sind vom wem besetzt? Da ist etwas mehr zu tun.
    besetzt = {}
    for s in [@spieler_o, @spieler_x]
      besetzt[s] = []
    end
    for zug in @zuege
      # Liegt der zug in der fraglichen Reihe?
      feld = zug.nummer
      if reihe.include?(feld)
        besetzt[zug.spieler] << feld
      end
    end
    [besetzt, frei]
  end

  def freie_felder
    frei = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    for zug in @zuege
      frei.delete(zug.nummer)
    end
    frei
  end
  
  # Schaut nach, ob alle Züge gemacht sind
  def felder_frei?
    @zuege.nil? ? true : @zuege.size < 9
  end
  
  def Spielfeld.reihen
    @@reihen
  end
  
  private

  # Methode zum Ausgeben einer einzigen Zeile im Ausgabebereich 'aus'.
  # Welche Zeile ausgegeben werden soll ist in 'zeile' übergeben.
  def print_zeile(aus, zeile)
    spalte = 1
    1.upto(3) do 
      print_feld(aus, spalte, zeile)
      aus.print " | " unless spalte == 3
      spalte += 1
    end
  end

  # Methode, die ein bestimmtes Feld ausgibt. Entweder wird
  # das Symbol für den Spieler ausgegeben, der das Feld besetzt hat,
  # oder es wird die laufende Nummer des Feldes ausgegeben, sofern
  # die Feldnummerierung angeschaltet ist.
  def print_feld(aus, spalte, zeile)
    res = " " 
    res = ((spalte-1)*1 + (zeile-1)*3 + 1) if @feldnummerierung
    # Den Zug suchen, der an dieser Stelle auszugeben ist.
    for zug in @zuege do
      if zug.spalte == spalte and zug.zeile == zeile
        res = zug.spieler
        break
      end
    end
    aus.print res
  end

end

class TicTacToe
  attr_accessor :strategie

  def initialize(strategie = nil)
    @spielfeld = Spielfeld.new
    @strategie = strategie.nil? ? LeichteSpielStrategie.new : strategie
  end

  def feldnummerierung_ein
    @spielfeld.feldnummerierung = true
  end

  def feldnummerierung_aus
    @spielfeld.feldnummerierung = false
  end

  def play(aus, ein)
    @spielfeld.print(aus)
    gewinner = the_winner_is
    beendet  = !@spielfeld.felder_frei? or (gewinner != nil)
    spieler = @spielfeld.spieler

    wer = nil
    aus.print "Was spielst du, X oder O? "
    eingabe = ein.gets.downcase.chomp
    wer = (eingabe == 'x') ? 1 : 0

    aus.print "Los geht's! Du spielst #{spieler[wer]}, und ich #{spieler[1^wer]}!"
    aus.puts " Du faengst an."

    while true
      # Der menschliche Spieler zuerst
      zug_okay = false
      until zug_okay
        aus.print "#{spieler[wer]} ist am Zug: "
        nummer = ein.gets.to_i
        break if nummer == 0
        zug_okay = @spielfeld.zug_hinzu(Zug.new(spieler[wer], nummer))
      end
      @spielfeld.print(aus)
      gewinner = the_winner_is
      beendet  = ((!@spielfeld.felder_frei?) or (gewinner != nil))
      break if (beendet or !zug_okay)
      wer += 1
      wer %= 2

      # Gleich den Zug des Computers anschließen
      zug_okay = false
      until zug_okay
        aus.print "\nJetzt bin ich dran! "
        zug = computer_zug(spieler[wer])
        break if zug.nil?
        aus.puts "Ich setze auf das Feld #{zug.nummer}."
        zug_okay = @spielfeld.zug_hinzu(zug)
      end
      @spielfeld.print(aus)
      gewinner = the_winner_is
      beendet  = ((!@spielfeld.felder_frei?) or (gewinner != nil))

      break if (beendet or !zug_okay)
      wer += 1
      wer %= 2
    end
    # Rückgabewerte: der aktuelle Spieler, falls er der Gewinner ist.
    if gewinner != nil
      return spieler[wer]
    else
      return nil
    end
    
  end

  # Lässt 2 Spieler miteinander spielen
  def play_2_spieler(aus, ein)
    @spielfeld.print(aus)

    gewinner = the_winner_is
    spieler = @spielfeld.spieler
    gewinner = nil
    wer = 0
    while true
      zug_okay = false
      until zug_okay
        aus.print "#{spieler[wer]} ist am Zug: "
        nummer = ein.gets.to_i
        break if nummer == 0
        zug_okay = @spielfeld.zug_hinzu(Zug.new(spieler[wer], nummer))
      end
      @spielfeld.print(aus)
      gewinner = the_winner_is
      beendet  = ((!@spielfeld.felder_frei?) or (gewinner != nil))
      break if (beendet or !zug_okay)
      wer += 1
      wer %= 2
    end
    # Rückgabewerte: der aktuelle Spieler, falls er der Gewinner ist.
    if gewinner != nil
      return spieler[wer]
    else
      return nil
    end
  end
  

  def computer_zug(aktueller_spieler)
    @strategie.next(@spielfeld, aktueller_spieler)
  end
  

  private

  # Stellt fest, ob es einen Gewinner gibt
  def the_winner_is
    # Variable für den Gewinner
    the_winner = nil

    # Für alle Reihen testen
    for reihe in Spielfeld::reihen
      besetzt, frei = @spielfeld.reihen_status(reihe)

      # In der Reihe nur ein Gewinn, wenn kein Feld mehr frei
      if frei.size == 0
        for spieler in @spielfeld.spieler
          # spieler hat in dieser Reihe gewonnen, wenn er alle
          # 3 möglichen Felder besetzt hat
          the_winner = spieler if besetzt[spieler].size == 3
          break if the_winner != nil # Gewinner gefunden, for-spieler-Schleife verlassen
        end
      end

      # Wenn es einen Gewinner gibt, ist es nicht mehr notwendig,
      # in den anderen Reihen nachzuschauen.
      break if the_winner != nil # for-reihe-Schleife verlassen
    end

    the_winner
  end
end

class SpielStrategie

  def next(spielfeld, aktueller_spieler)
    zufalls_zug(spielfeld, aktueller_spieler)
  end

  def zufalls_feld(felder)
    feld = nil
    if felder.size > 0
      jetzt = Time.now
      sekunden = jetzt.sec
      index = sekunden % felder.size
      feld = felder[index]
    end
    feld
  end

  private

  def zufalls_zug(spielfeld, aktueller_spieler)
    zug = nil
    feld = zufalls_feld(spielfeld.freie_felder)
    zug = Zug.new(aktueller_spieler, feld) if feld != nil
    zug
  end
  
end

class LeichteSpielStrategie < SpielStrategie

  def next(spielfeld, aktueller_spieler)
    naiver_zug(spielfeld, aktueller_spieler)
  end

  def naiver_zug(spielfeld, aktueller_spieler) 
    frei = spielfeld.freie_felder
    zug = nil
    if frei.size > 0
      # Nehme das erste freie Feld
      zug = Zug.new(aktueller_spieler, frei[0])
    end
    zug
  end
end

class SchwereSpielStrategie < LeichteSpielStrategie
  def next(spielfeld, aktueller_spieler)
    intelligenter_zug(spielfeld, aktueller_spieler)
  end

  # Implementiert einige Regeln, mit deren Hilfe man sehr wahrscheinlich
  # nicht verliert.
  def intelligenter_zug(spielfeld, aktueller_spieler)
    zug = nil

    spieler = spielfeld.spieler
    gegner  = nil
    for s in spieler
      if s.name != aktueller_spieler.name
        gegner = s
        break
      end
    end
    
    # 1. Regel: Zuerst nach einer Gewinnsituation suchen
    for reihe in Spielfeld::reihen
      besetzt, frei = spielfeld.reihen_status(reihe)
      
      # Wenn der aktuelle Spieler in einer Reihe bereits zwei Felder
      # besetzt hält und das dritte frei ist, dann natürlich das nehmen
      if (frei.size == 1) and (besetzt[aktueller_spieler].size == 2)
        zug = Zug.new(aktueller_spieler, frei[0])
        break # nicht weitersuchen
      end
    end
    
    if zug.nil?
      # 2. Regel: Suche dann nach den Reihen, in denen der Gegner bereits
      # genau 2 Felder besetzt hat und das dritte Feld noch frei ist.
      for reihe in Spielfeld::reihen
        besetzt, frei = spielfeld.reihen_status(reihe)
          
        # Gefährlich, wenn Gegner zwei besetzt hält. Wie in der vorherigen
        # Lektion gelernt, erhält man zum Index des aktuellen Spielers
        # in der Spielerliste den Index des Gegners mit der Bitoperation 1^wer
        if (frei.size == 1) and (besetzt[gegner].size == 2)
          # Jetzt muss der Spieler unbedingt das eine freie Feld besetzen!
          # Andernfalls kann der Gegner im nächsten Zug gewinnen.
          zug = Zug.new(aktueller_spieler, frei[0])
          break # nicht weitersuchen
        end
      end
    end

    # Eckensituation bestimmen
    ecken = {
      1 => 0, # links oben
      3 => 0, # rechts oben
      7 => 0, # links unten
      9 => 0  # rechts unten
    }
    gegen_ecken = [[1, 9], [9, 1], [3, 7], [7, 3]]
    for z in spielfeld.zuege
      feld = z.nummer
      # Gegner besetzt die Ecke, wenn:
      #   feld ist eine Ecke  und  Gegner besetzt sie
      if (ecken[feld] != nil) and (z.spieler == gegner)
        # Markiere Ecke als vom Gegner besetzt
        ecken[feld] = 1
      end
    end
    
    # 3. Regel: Immer in die Mitte setzten, falls dort frei ist
    # Vorsicht vor der XOX Situation an der Diagonale!
    if zug.nil?
      frei  = spielfeld.freie_felder
      mitte = 5
      if frei.include?(mitte)
        zug = Zug.new(aktueller_spieler, mitte)
      else
        # Aha, Mitte ist bereits besetzt. 
        # Sofern sie vom aktuellen Spieler besetzt ist, dann nach der XOX 
        # Situation Ausschau halten und den nächsten Zug nicht in eine Ecke setzen.
        # XOX (oder OXO) Situation besteht, wenn
        # Ecke 1 und 9 vom Gegner besetzt und aktueller Spieler auf 5 oder
        # Ecke 3 und 7 vom Gegner besetzt und aktueller Spieler auf 5.
        for ecken_paar in gegen_ecken
          besetzt, frei_ecken = spielfeld.reihen_status([ecken_paar[0], mitte, ecken_paar[1]])
          if besetzt[gegner].include?(ecken_paar[0]) and besetzt[gegner].include?(ecken_paar[1])
            if besetzt[aktueller_spieler].include?(mitte)
              # Jetzt also nicht in eine freie Ecke setzen, sondern auf
              # die Felder 2, 4, 6 oder 8, sofern sie frei sind.
              xox_felder = [2, 4, 6, 8]
              for f in xox_felder
                if !frei.include?(f)
                  xox_felder.delete(f)
                end
              end
              # Von den freien Ausweichfeldern zufällig eines nehmen
              feld = zufalls_feld(xox_felder)
              if feld != nil
                zug = Zug.new(aktueller_spieler, feld) 
                break
              end
            end
          end
        end
        
      end
    end
    
    # 4. Regel: Verteidige gegenüberliegende Ecke
    frei  = spielfeld.freie_felder
    if zug.nil?
      # Wenn Ecke 1 besetzt, dann setze auf 9, oder umgekehrt (sofern frei).
      # Wenn Ecke 3 besetzt, dann setze auf 7, oder umgekehrt (sofern frei).
      for ecken_paar in gegen_ecken
        if (ecken[ecken_paar[0]] > 0) and (frei.include?(ecken_paar[1]))
          zug = Zug.new(aktueller_spieler, ecken_paar[1])
          break # nicht weitersuchen
        end
      end
    end

    # 5. Regel: Setze in irgendeine freie Ecke.
    # Verwende Variablen 'frei' und 'ecken' von oben
    if zug.nil?
      for ecke in ecken.keys
        if frei.include?(ecke)
          zug = Zug.new(aktueller_spieler, ecke)
          break # nicht weitersuchen
        end
      end
    end

    # Andernfalls Zufallszug machen
    if zug.nil?
      zug = zufalls_zug(spielfeld, aktueller_spieler)
    end
    
    zug
  end
  
end
