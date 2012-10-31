# Copyright (C) 2007-2008 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
# lektion_22.rb

require 'fox16'
require 'fox16/colors'

include Fox

class RubykidsMainWindow < FXMainWindow
  def initialize(app)
    super(app, "Rubykids.de", :opts => DECOR_ALL, :width => 800, :height => 600)
    
    @hauptFrame = FXHorizontalFrame.new(
      self,
      LAYOUT_SIDE_TOP|LAYOUT_FILL_X|LAYOUT_FILL_Y,
      :padLeft   => 0,
      :padRight  => 0,
      :padTop    => 0,
      :padBottom => 0
    )

    # * * * Linker Leinwandbereich
    @leinwandFrame = FXVerticalFrame.new(
      @hauptFrame,
      LAYOUT_TOP|LAYOUT_LEFT|LAYOUT_FILL_X|LAYOUT_FILL_Y,
      :padLeft   => 20,
      :padRight  => 20,
      :padTop    => 20,
      :padBottom => 20
    )

    FXLabel.new(
      @leinwandFrame, 
      "Malbereich", 
      :opts => JUSTIFY_CENTER_X|LAYOUT_FILL_X
    )

    FXHorizontalSeparator.new(
      @leinwandFrame,
      SEPARATOR_GROOVE|LAYOUT_FILL_X
    )

    @leinwand = FXCanvas.new(
      @leinwandFrame,
      :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y|LAYOUT_TOP|LAYOUT_LEFT
    )

    @leinwand.connect(
      SEL_PAINT, 
      method(:onLeinwandRepaint)
    )
    
    

    # * * * Rechter Bereich für Buttons
    @menuFrame = FXVerticalFrame.new(
      @hauptFrame,
      LAYOUT_TOP|LAYOUT_LEFT|LAYOUT_FILL_Y,
      :padLeft   => 20,
      :padRight  => 20,
      :padTop    => 20,
      :padBottom => 20
    )

    FXLabel.new(
      @menuFrame, 
      "Menü", 
      :opts => JUSTIFY_CENTER_X|LAYOUT_FILL_X
    )

    FXHorizontalSeparator.new(
      @menuFrame,
      SEPARATOR_GROOVE|LAYOUT_FILL_X
    )

    FXButton.new(
      @menuFrame,
      "&Beenden\tAnwendung beenden",
      nil,
      getApp(),
      FXApp::ID_QUIT,
      :opts => FRAME_THICK|FRAME_RAISED|LAYOUT_FILL_X|LAYOUT_TOP|LAYOUT_LEFT,
      :padLeft   => 10, 
      :padRight  => 10,
      :padTop    => 5,
      :padBottom => 5
    )
  end

  # In die Leinwand etwas einzeichnen
  def onLeinwandRepaint(sender, sel, event)
    FXDCWindow.new(@leinwand, event) do |dc|
      dc.foreground = FXRGB(255, 255, 255)
      dc.fillRectangle(0, 0, @leinwand.width, @leinwand.height)

      # Einen LKW malen
      # Karosserie
      dc.foreground = FXColor::Blue
      dc.fillRectangle(30, 20, 30, 10) # Oberes Teil
      dc.fillRectangle(30, 30, 40, 10) # Unteres Teil

      # Seitenfenster
      dc.foreground = FXColor::DarkBlue
      dc.fillRectangle(32, 22, 15, 6) # Hinten
      dc.fillRectangle(48, 22, 10, 6) # Vorne

      # Mit Hintergrundfarbe einen Bereich für die 
      # Räder aus der Karosse schneiden
      dc.foreground = FXColor::White
      dc.fillCircle(38, 40, 5) # Hinten
      dc.fillCircle(62, 40, 5) # Vorne

      # Reifen anbringen
      dc.foreground = FXColor::Black
      dc.fillCircle(38, 40, 4) # Hinten
      dc.fillCircle(62, 40, 4) # Vorne

      # Felgen drüber malen
      dc.foreground = FXColor::White
      dc.fillCircle(38, 40, 2) # Hinten
      dc.fillCircle(62, 40, 2) # Vorne

      # Rücklicht
      dc.foreground = FXColor::Red
      dc.fillRectangle(29, 30, 2, 6)
      
      # Blinklicht vorne
      dc.foreground = FXColor::DarkOrange
      dc.fillRectangle(67, 32, 3, 2)
    end
  end

  # Wird von application.create aufgerufen
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

application = FXApp.new
    mainWin = RubykidsMainWindow.new(application)
application.create
application.run

