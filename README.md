[icon](icon.png) 

# flint.sh
Flint is a free and open-source command line tool for managing markdown notes. Notes are grouped into folders where each note has a title and group `title.group.md`.

## Features
- [gum](https://github.com/charmbracelet/gum) for pretty cli visuals
- syncing notes using git

## Installation
Clone the repo and run the install script:
```bash
git clone https://github.com/dungatoro/flint.sh
cd flint.sh
./install.sh
```
After that you can delete the `flint.sh` repo folder with no worries. `flint` will be in you `$PATH` and call be called with just `flint`.

For those that aren't just using plain bash and execute another shell like fish at the end of the bash script, you will need to move the line `export PATH="$PATH:$HOME/.flint"` somewhere above where this other shell is called. e.g.
```bash
export EDITOR='nvim'
export PATH="$PATH:$HOME/.flint"

fish
```

## todo!()
- [ ] listing based on groups
- [ ] graph view cos obsidian
