# Copyright (C) 2007 www.rubykids.de Frithjof Eckhardt
# Alle Rechte vorbehalten.
$KCODE='UTF-8'
require 'jcode'
begin
  require 'Win32API'
rescue LoadError
  # Unter Linux gibt es Win32API nicht, daher
  # den LoadError hier abfangen.
end

# Damit Ein- und Ausgabe auch in der Eclipse Console funktionieren:
$stdout.sync = true

class Array
  def laenge
    self.size
  end
  def jedes
    self.each do |elm|
      yield(elm)
    end
  end
end

class Liste < Array
  def self.neu(anInteger=0, anObject=nil)
    self.new(anInteger, anObject)
  end
end

class String
  def laenge
    self.jlength
  end
  def buchstaben_klein
    self.downcase
  end
  def buchstaben_gross
    self.upcase
  end
  def ohne_enter
    self.chomp
  end
end

class Fixnum
  def mal
    self.times do |cnt|
      yield(cnt)
    end
  end
  def biszu(target)
    self.upto(target) do |cnt|
      yield(cnt)
    end
  end
  def rest_bei_div(zahl)
    self % zahl
  end
end

class Bignum
  def mal
    self.times do |cnt|
      yield(cnt)
    end
  end
end

class Zeit < Time
  def self.jetzt
    self.now
  end
end


def schreib(*elemente)
  elemente.each do |t|
    print t
  end
end

def schreibe(*elemente)
  schreib(elemente)
  puts
end

def schreibe_leer(lines = 1)
  1.upto(lines) { puts }
end

# Diese Methode liest ein Zeichen ohne Zeilenvorschub (Enter).
# Das funktioniert leider bisher nur unter MS Windows.
def lies_ein_zeichen
  begin
    (Win32API.new("crtdll", "_getch", [], "L").Call).chr
  rescue NameError
    # Wenn Fehler, dann wohl kein Microsoft Windows da draußen.
    state = `stty -g`
    begin
      system("stty raw -echo cbreak")
      STDIN.getc.chr
    ensure
      system("stty #{state}")
    end
  end
end

def lies_eine_zeichenkette
  gets
end

def schlafe(sekunden = 0)
  sleep(sekunden)
end

def schlafe_kurz
  sleep(0.08)
end
