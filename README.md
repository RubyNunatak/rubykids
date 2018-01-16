Programmbeispiele in Ruby
-------------------------

Allgemeines
-----------

Die Programme lassen sich wie üblich von Konsole (MS-DOS Fenster, oder Linux Terminal) 
aus starten oder in eine Entwicklungsumgebung importieren (bspw. Eclipse).

Alle Dateien sind im UTF-8 Format. Daher evtl. in Eclipse den Content Type für
Ruby Quellecode Dateien umstellen: Window / Preferences / General / Content Types, und dort im Zweig Text / Ruby Source File, das Default Encoding auf utf-8 einstellen.


Anmerkungen zu Teil 1
---------------------

Alle Lektionen im Teil 1 funktionieren korrekt, wenn sie direkt in einem DOS-Fenster (Windows), 
bzw. im Terminalfenster (Linux) ausgeführt werden. 

In Eclipse gibt es einige Einschränkungen, leider. Beispielsweise
funktioniert die Lektion 7 (Fahrrad hin und her fahren) in Eclipse nicht.
Eclipse hat Probleme mit dem Einlesen eines einzelnen Zeichens ohne 
Zeilenvorschub.
  
Aufruf an der Kommandozeile am Beispiel der Lektion 7 im DOS-Fenster unter Windows:


        C:\rubykids> ruby teil_01\lektion_07.rb
        C:\rubykids\teil_01> ruby lektion_07.rb


Dasselbe im Terminalfenster unter Linux:


        frithjof@ubuntu:~/rubykids$ ruby teil_01/lektion_07.rb 
        frithjof@ubuntu:~/rubykids/teil_01$ ruby lektion_07.rb 


        /^\   /^\   /^\   /^\   /^\   /^\   /^\   /^\   /^\   /^\   
        |.|   |.|   |.|   |.|   |.|   |.|   |.|   |.|   |.|   |.|   
        |_|:::|_|:::|_|:::|_|:::|_|:::|_|:::|_|:::|_|:::|_|:::|_|:::
        ____________________________________________________________
        ............................................................
        o^o_________________________________________________________

Oder man verwendet das Run-Script, **run.cmd** unter Windows bzw. **run.sh** unter Linux.

        C:\rubykids\teil_01> run 07
        frithjof@ubuntu:~/rubykids/teil_01$ ./run.sh 07 

Im Teil 1 wird eine kleine Bibliothek 'rubykids.rb' verwendet, die den Einstieg
in Ruby erleichtern soll, indem sie englische Befehle und Besonderheiten
der Sprache Ruby versteckt. 

Damit diese Bibliothek durch den 'require' Befehl auch beim Ausführen der
Programme in Eclipse korrekt gefunden wird, sieht der 'require' Befehl hier 
etwas komplizierter aus. Anstatt

        require 'rubykids'

steht

        require File.dirname(__FILE__) +  "/rubykids"

Dadurch erhält der Rubyinterpreter den absoluten Pfad zur Datei rubykids.rb
und es sollte auch in Eclipse keine Probleme geben.

Entwickelt wurde bisher mit Ruby 1.8. Inzwischen ist Ruby 1.9 weit verbreitet und der Code soweit überarbeitet,
dass die meisten Lektionen auch mit Ruby 1.9 unter Windows und Linux funktionieren.
