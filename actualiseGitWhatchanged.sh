#!/bin/sh
#DIR='/tmp/tmuxDE/'$(cat /dev/urandom | tr -cd '[a-zA-Z0-9_]' |head -c 20)
#mkdir -p $DIR
DIR=$(mktemp -d -t ACTUALISEGITWHATCHANGED.XXXXXXXXX)
echo > $DIR/whatch
while true; do
   WIDTH=`stty size | cut -d ' ' -f 2`
   HEIGHT=`stty size | cut -d ' ' -f 1`
   git whatchanged --format='format:%Creset%h %C(ul)%an%Creset %ad%n%C(bold green)%s%C(yellow)' > $DIR/whatch1
   #git whatchanged --format='format:%Creset%h %C(ul)%an%Creset %ad%n%C(bold green)%s%C(yellow)' |cat | perl -pe 's/^((?:(?>(?:\e\[.*?m)*).){'$WIDTH'}).*/$1\e[m/' | head -n $(( HEIGHT - 1))
   if ! $(diff -q $DIR/whatch $DIR/whatch1 > /dev/null); then
      clear
      echo ------------------------------------------------------------------------------------------|cut -c 1-$WIDTH
      echo
      cat $DIR/whatch1 | perl -pe 's/^((?:(?>(?:\e\[.*?m)*).){'$WIDTH'}).*/$1\e[m/' | head -n $(( $HEIGHT - 1))
      mv $DIR/whatch1 $DIR/whatch
   fi
   sleep 1
done
rm -r DIR
