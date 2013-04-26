#!/usr/bin/env bash

DIR=$(mktemp -d -t ACTUALISEGITSTATUS.XXXXXX)
echo > $DIR/whatch

WIDTH=`stty size | cut -d ' ' -f 2`
HEIGHT=`stty size | cut -d ' ' -f 1`

(
while true; do
   git status > $DIR/whatch1
   if ! $(diff -q $DIR/whatch $DIR/whatch1 > /dev/null); then
      clear
      echo ------------------------------------------------------------------------------------------|cut -c 1-$WIDTH
      echo
      cat $DIR/whatch1 | perl -pe 's/^((?:(?>(?:\e\[.*?m)*).){'$WIDTH'}).*/$1\e[m/' | head -n $(( HEIGHT - 1))
      cp $DIR/whatch1 $DIR/whatch
   fi
   # On doit inclure .git/ pour prendre en compte les git add et cie.
   inotifywait -qq -r -e modify -e move -e create -e delete -e delete_self .
done
) &

PID=$!
echo $PID
breakloop() {
   echo "killing"
   kill $PID
   kill $PID
}

echo started
trap breakloop SIGINT
wait $PID

# Ne s'affiche pas ???
echo "End of the program"
