# Copyright (C) 2007-2008 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_21.rb

require 'fox16'

application = Fox::FXApp.new

mainWin = Fox::FXMainWindow.new(application, "Rubykids.de")
Fox::FXLabel.new(mainWin, "Hallo, Welt!")

application.create
mainWin.show(Fox::PLACEMENT_SCREEN)
application.run

