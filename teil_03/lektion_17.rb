# lektion_17.rb

require File.dirname(__FILE__) +  "/tictactoe_lektion_17"

t = TicTacToe.new
t.strategie = SchwereSpielStrategie.new
t.feldnummerierung_aus
gewinner = t.play(STDOUT, STDIN)
#gewinner = t.play_2_spieler(STDOUT, STDIN)

# Gibt es einen Gewinner?
if gewinner == nil
  puts "Das Spiel endet UNENTSCHIEDEN!"
else
  puts "Der Gewinner ist #{gewinner}!"
end
