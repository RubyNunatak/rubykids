# lektion_23.rb

require 'fox16'
require 'fox16/colors'

include Fox

class LKW
  def initialize(col_background = FXColor::White)
    @col_background = col_background
    @col_dach       = FXColor::Black
    @col_karosse    = FXColor::Blue
    @col_fenster    = FXColor::DarkBlue
    @col_reifen     = FXColor::Black
    @col_felgen     = FXColor::White
    @col_ruecklicht = FXColor::Red
    @col_blinker    = FXColor::DarkOrange
  end

  def draw(dc, pos = FXPoint.new(0,0))
    return if dc.nil?
    # Karosserie
    dc.foreground = @col_karosse
    dc.fillRectangle(pos.x, pos.y,    30, 10) # Oberes Teil
    dc.fillRectangle(pos.x, pos.y+10, 40, 10) # Unteres Teil

    # Dach
    dc.foreground = @col_dach
    dc.drawLine(pos.x, pos.y, pos.x+30, pos.y)

    # Seitenfenster
    dc.foreground = @col_fenster
    dc.fillRectangle(pos.x+2,  pos.y+2, 15, 6) # Hinten
    dc.fillRectangle(pos.x+18, pos.y+2, 10, 6) # Vorne

    # Mit Hintergrundfarbe einen Bereich für die
    # Räder aus der Karosse schneiden
    dc.foreground = @col_background
    dc.fillCircle(pos.x+8,  pos.y+20, 5) # Hinten
    dc.fillCircle(pos.x+32, pos.y+20, 5) # Vorne

    # Reifen anbringen
    dc.foreground = @col_reifen
    dc.fillCircle(pos.x+8,  pos.y+20, 4) # Hinten
    dc.fillCircle(pos.x+32, pos.y+20, 4) # Vorne

    # Felgen drüber malen
    dc.foreground = @col_felgen
    dc.fillCircle(pos.x+8,  pos.y+20, 2) # Hinten
    dc.fillCircle(pos.x+32, pos.y+20, 2) # Vorne

    # Rücklicht
    dc.foreground = @col_ruecklicht
    dc.fillRectangle(pos.x-1, pos.y+10, 2, 6)

    # Blinklicht vorne
    dc.foreground = @col_blinker
    dc.fillRectangle(pos.x+37, pos.y+12, 3, 2)
  end
end

class RubykidsMainWindow < FXMainWindow
  KEY_ARROW_LEFT  = 65361
  KEY_ARROW_UP    = 65362
  KEY_ARROW_RIGHT = 65363
  KEY_ARROW_DOWN  = 65364

  def initialize(app)
    super(app, "Rubykids.de", :opts => DECOR_ALL, :width => 400, :height => 300)

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

    @leinwand.connect(SEL_PAINT, method(:onLeinwandRepaint))

    @leinwand.connect(SEL_LEFTBUTTONPRESS,  method(:onMouseDown))
    @leinwand.connect(SEL_RIGHTBUTTONPRESS, method(:onMouseDown))
    @leinwand.connect(SEL_MOUSEWHEEL, method(:onMouseWheel))
    @leinwand.connect(SEL_KEYPRESS, method(:onKeyPressed))



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

    # Variablen für die Position des LKW
    @current_pos    = FXPoint.new(30, 20)
    @move_distance  = FXPoint.new(8, 8)

    @col_background = FXRGB(255, 255, 255)
    @lkw = LKW.new(@col_background)

  end

  # In die Leinwand etwas einzeichnen
  def onLeinwandRepaint(sender, sel, event)
    FXDCWindow.new(@leinwand, event) do |dc|
      dc.foreground = @col_background
      dc.fillRectangle(0, 0, @leinwand.width, @leinwand.height)

      pos = FXPoint.new(@current_pos.x, @current_pos.y)
      [
        [0,               0],                # Aktuelle Position des LKW
        [@leinwand.width, 0],                # Verschoben nach links
        [0,               @leinwand.height], # Verschoben nach oben
        [@leinwand.width, @leinwand.height]  # Verschoben nach links oben
      ].each do |off|
        pos.x = @current_pos.x - off[0]
        pos.y = @current_pos.y - off[1]

        @lkw.draw(dc, pos)
      end
    end
  end

  def onMouseDown(sender, sel, event)
    if event.click_button == 1
      # Linke Maustaste
      self.move_forward
    elsif event.click_button == 3
      # Rechte Maustaste
      self.move_backward
    end
  end

  def onMouseWheel(sender, sel, event)
    if event.code > 0
      self.move_forward
    elsif event.code < 0
      self.move_backward
    end
  end

  def onKeyPressed(sender, sel, event)
    if event.code == KEY_ARROW_LEFT
      self.move_backward
    elsif event.code == KEY_ARROW_RIGHT
      self.move_forward
    elsif event.code == KEY_ARROW_UP
      self.move_up
    elsif event.code == KEY_ARROW_DOWN
      self.move_down
    end
  end

  def move_forward
    @current_pos.x = (@current_pos.x + @move_distance.x) % @leinwand.width
    @current_pos.y = (@current_pos.y                   ) % @leinwand.height
    @leinwand.update
  end

  def move_backward
    @current_pos.x = (@current_pos.x - @move_distance.x) % @leinwand.width
    @current_pos.y = (@current_pos.y                   ) % @leinwand.height
    @leinwand.update
  end

  def move_up
    @current_pos.x = (@current_pos.x                   ) % @leinwand.width
    @current_pos.y = (@current_pos.y - @move_distance.y) % @leinwand.height
    @leinwand.update
  end

  def move_down
    @current_pos.x = (@current_pos.x                   ) % @leinwand.width
    @current_pos.y = (@current_pos.y + @move_distance.y) % @leinwand.height
    @leinwand.update
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
