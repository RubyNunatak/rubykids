#!/bin/sh
case "$1" in
  07)     ruby theorie_07.rb ;;
  1[1-7]) ruby lektion_$1.rb ;;
  18)     echo "Lektion 18 im Unterverzeichnis direkt ausfuehren." ;;
  19|20)  ruby lektion_$1/lektion_$1.rb ;;
   *)     ruby lektion_$1.rb ;;
esac
