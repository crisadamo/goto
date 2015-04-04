function goto
  set -g VERSION "0.3 (fat butt)"
  set -g DB "$HOME/.gotostore"

  function usage
    echo "Usage: goto [OPTION]... [MODIFIERS]... "
    echo "Example: goto add pepe '/home/pepe/'"
    echo
    echo "Options:"
    echo "--------"
    echo "  [key]:                                  Go to the setted path."
    echo "  list | ls | l:                          List all available jumps."
    echo "  [remove | rm | d ] [key-name | all]:    Delete the specified key or all keys"
    #echo "  rename | rn | r [old-key] [new-key]:   Rename a given key"
    echo "  add | a:                                Add a path to the jump list."
    echo "    Modifiers:"
    echo "    ----------"
    echo "      this | . :                          Add the current path and set the 'jump' "
    echo "                                          key to the current directory name."
    echo "      [this | .] as [key]:                Add the current path and specify the 'jump' key."
    echo "      [key] [path]:                       Add the desired path with the key."
    echo "  verion | v:                             Shows the current version."
    echo "  help | h:                               Shows this menu."
  end

  function validate
    grep -P "[A-Za-z-_0-9]*"
  end

  function prettyPrint
    echo "$argv[1]" | sed s/\=\/" => "/ | xargs -I line echo "  " line
  end

 # Application Functions --------------------------------------------------------
  function go
    set search_key $argv[1]
    set dest (grep "^$search_key=" $DB | grep -oP "=\K(.*)" )
    cd $dest
  end

  function addKey
    set entry ""
    switch $argv[1]
      case this .
        set current_dir (basename $PWD)

        if test $argv[2] = "as"
          set entry "$argv[3]=$PWD"
        else
          set entry "$current_dir=$PWD"
        end
      case "*"
        set entry "$argv1=$argv[2]"
    end

    if not test entry = ""
      echo " Adding: $entry"
      echo $entry >> $DB
    end
  end

  function removeKey
    set del_key "$argv[1]"
    if test $del_key = "all"
      echo "" >$DB
      echo " The list has been cleaned."
    else if not test $del_key = ""
      sed -i "/^$del_key=/d" $DB
      echo " $del_key was removed."
    else
      echo " There is no key to remove."
    end
  end

  function listEntries
    echo "List of available jumps:"
    cat $DB | sed s/\=\/" => "/ | xargs -I line echo "  " line
  end


  # Main Application Loop --------------------------------------------------------
  if not test -f $DB
    touch "$DB"
  end

  if test -z $argv[1]
    set argv "h"
  end

  switch $argv[1]
    case add a
      addKey $argv[2] $argv[3] $argv[4]
    case remove rm d
      removeKey $argv[2]
    case list ls l
      listEntries
    case version v
      echo current ver. $VERSION
    case help h
      usage
    case "*"
      go $argv[1]
    end
end
