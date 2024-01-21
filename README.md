 # Using my dotfiles on your device
1. To prevent weird circular dependencies, first execute:
``` 
echo ".cfg" >> .gitignore 
```
2. Then clone the repository to `$HOME/.cfg`:
``` 
git clone --bare https://github.com/Excse/dotfiles $HOME/.cfg 
```
3. Add the alias to your shell and disable untracked files being showed:
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```

4. Proceed to checkout
```
config checkout
```
 
