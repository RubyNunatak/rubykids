class Zeitansage
  def initialize(anreden, zeitmuster)
    @anreden    = anreden
    @zeitmuster = zeitmuster
  end

  def es_ist
    zeit = Time.now.strftime(@zeitmuster)
    "#{anrede} #{zeit}"
  end

  private

  def anrede
    text = ""
    unless @anreden.nil?
      idx = zufalls_zahl(@anreden.length)
      text = @anreden[idx]
    end
    text
  end

  # Liefert keine wirkliche Zufallszahl, für diese
  # Zwecke hier ist es aber ausreichend.
  def zufalls_zahl(max)
    (max > 0) ? (Time.now.sec % max) : 0
  end
  
end
