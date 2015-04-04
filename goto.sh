#!/bin/bash

VERSION="0.3 (flat butt)"
DB="$HOME/.gotostore"

CMD=$1
MOD1=$2
MOD2=$3
MOD3=$4
MOD4=$5
MOD5=$6

# Utility Functions ------------------------------------------------------------
function usage() {
  echo "Usage: goto [OPTION]... [MODIFIERS]... "
  echo "Example: go add pepe '/home/pepe/'"
  echo
  echo "Options:"
  echo "--------"
  echo "  [key]:                                  Go to the configured path."
  echo "  list | ls | l:                          List all available jumps."
  echo "  remove | rm | d [key] | all:            Delete the specified key or all keys"
  #echo "  rename | rn | r [old-key] [new-key]:    Rename a given key"
  echo "  add | a:                                Add a path to the jump list."
  echo "    Modifiers:"
  echo "    ----------"
  echo "      this | . :                          Add the current path and set the 'jump' "
  echo "                                          key to the directory name."
  echo "      this | . as [key]:                  Add the current path and set the 'jump' key."
  echo "      [key] [path]:                       Add the desired path with the key."
  echo "  verion | v:                             Shows the current version."
  echo "  help | v:                               Shows this menu."
}

function validate() {
  grep -P "[A-Za-z-_0-9]*"
}

function prettyPrint() {
  echo "$1" | sed s/\=\/" => "/ | xargs -I line echo "  " line
}

# Application Functions --------------------------------------------------------
function setup() {
  if [ ! -f $DB ]; then
    touch "$DB"
  fi
}

function go() {
  local search_key=$1
  local dest=
  dest=$(grep "^$search_key=" $DB | grep -oP "=\K(.*)" )
  cd $dest
}

function add() {
  local entry=""
  case $MOD1 in
    this | .)
      local current_dir=$(basename $PWD)

      if [[ $MOD2 == "as" ]]; then
        entry="$MOD3=$PWD"
      else
        entry="$current_dir=$PWD"
      fi
      ;;
    *)
      entry="$MOD1=$MOD2"
      ;;
  esac

  if [ $entry != "" ]; then
    echo " Adding: $entry"
    echo $entry >> $DB
  fi
}

function delete() {
  local del_key=$1
  if [ $del_key == "all" ]; then
    > $DB
    echo " The list has been cleaned."
  elif [ $del_key != "" ]; then
    sed -i '/^$del_key=/d' $DB
    echo " $del_key was removed."
  else
    echo " There is no key to remove."
  fi
}

function list() {
  echo "List of available jumps:"
  cat $DB | sed s/\=\/" => "/ | xargs -I line echo "  " line
}


# Main Application Loop --------------------------------------------------------
setup

case $CMD in
  add | a)
    add
    ;;
  remove | rm | d)
    delete $MOD1
    ;;
  #rename | rn | r)
  #  rename
  #  ;;
  list | ls | l)
     list
    ;;
  version | v)
    echo "  current ver. $VERSION"
    ;;
  help | h)
    usage
    ;;
  *)
    go $CMD
    ;;
esac
