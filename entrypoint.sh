#!/bin/sh

set -e
set -x

args_contain() {
  local target="$1"
  shift

  while test $# -gt 0; do
    if [ "$1" == "$target" ]; then
      true
      return
    fi

    shift
  done

  false
}

main() {
  [ -z "$OTS_CALENDAR_URI" ] && echo "OTS_CALENDAR_URI must be defined" && exit 1

  mkdir -p $HOME/.otsd/calendar

  echo $OTS_CALENDAR_URI > $HOME/.otsd/calendar/uri
  [ -f $HOME/.otsd/calendar/hmac-key ] || dd if=/dev/random of=$HOME/.otsd/calendar/hmac-key bs=32 count=1


  mkdir -p $HOME/.bitcoin
  touch $HOME/.bitcoin/bitcoin.conf

  [ -n "$BITCOIN_RPCUSER" ] && echo "rpcuser=$BITCOIN_RPCUSER" >> $HOME/.bitcoin/bitcoin.conf
  [ -n "$BITCOIN_RPCPASSWORD" ] && echo "rpcpassword=$BITCOIN_RPCPASSWORD" >> $HOME/.bitcoin/bitcoin.conf
  [ -n "$BITCOIN_RPCPORT" ] && echo "rpcport=$BITCOIN_RPCPORT" >> $HOME/.bitcoin/bitcoin.conf
  [ -n "$BITCOIN_RPCCONNECT" ] && echo "rpcconnect=$BITCOIN_RPCCONNECT" >> $HOME/.bitcoin/bitcoin.conf

  cd /opt/opentimestamps-server

  ./otsd "$@"
}

main "$@"
