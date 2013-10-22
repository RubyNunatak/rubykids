#!/bin/sh
case "$1" in
  2[2-3]) ruby lektion_$1/lektion_$1.rb ;;
   *)     ruby lektion_$1.rb ;;
esac
