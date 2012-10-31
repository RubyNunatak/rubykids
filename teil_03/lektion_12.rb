# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_12.rb

require File.dirname(__FILE__) +  "/tictactoe_lektion_12"

# Variable für die Liste der Züge; Sie ist anfangs leer.
zuege = []

# Spielfeld auf der Standardausgabe einmal ausgeben.
spielfeld(STDOUT, zuege)

play_2_spieler(STDOUT, STDIN, zuege)
