# lektion_06.rb
require File.dirname(__FILE__) +  "/rubykids"

# if ... then ... end
richtung = "R"

if richtung == "R" then schreibe "Ich fahre nach rechts" end
if richtung == "L" then schreibe "Ich fahre nach links" end

# if ... then ... else ... end
if richtung == "R"
  schreibe "Ich fahre nach rechts"
else
  schreibe "Ich fahre nach links"
end

# Nachgestelltes if
schreibe "Ich fahre nach rechts" if richtung == "R"
schreibe "Ich fahre nach links"  if richtung == "L"


# Mehrere if nacheinander
richtung = "O"

if richtung == "R"
  schreibe "Ich fahre nach rechts"
elsif richtung == "L"
  schreibe "Ich fahre nach links"
elsif richtung == "O"
  schreibe "Ich fahre nach oben"
elsif richtung == "U"
  schreibe "Ich fahre nach unten"
end

# While Schliefe mit Einlesen von Zeichenkette
while zeichenkette = lies_eine_zeichenkette
  schreibe "Du hast die Zeichenkette '", zeichenkette.ohne_enter, "' eingegeben!"
end
