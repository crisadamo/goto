# Goto
A missing goto command for your shell

###### Go where you want, quickly



#### Install

Open the terminal and just paste this chuck of code on it and hit enter and you are done!

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
