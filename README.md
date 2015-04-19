# Goto
A missing goto command for your shell

###### Go where you want




#### Install

Open the terminal, paste this chuck of code on it and hit enter. ¡Boom! you are done. Enjoy!

###### For BASH shell:
```bash
(cd $HOME && 
wget https://raw.githubusercontent.com/crisadamo/goto/master/goto.sh &&
chmod u+x goto.sh &&
cp .bashrc .bashrc-backup &&
sed -i "1i alias goto=\". $HOME/goto.sh \$@\"" .bashrc &&
source $HOME/.bashrc)
```

###### For FISH shell:
```bash
mkdir -p $HOME/.config/fish/functions; 
and cd $HOME/.config/fish/functions; 
and wget https://raw.githubusercontent.com/crisadamo/goto/master/goto.fish; 
and chmod u+x goto.fish
```

#### Usage

```~$ goto add this as home``` : adds the current directory with the jump key "home".

```~$ goto add this``` :  adds the current directory with his name as jump key.

```~$ goto add home /home/username``` : adds the directory named "/home/username" with "home" has jump key.

```~$ goto home```: change directory to the registred one with home as jump key.

```~$ goto ls```: list the registred keys.

```~$ goto rm home```: deletes the registred jump key "home".

```~$ goto rm all```: deletes all jumps keys.

```~$ goto h```: help menu

