# Goto
A missing goto command for your shell

###### Go where you want to go quickly



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
coming soon
```
