#!/bin/bash

try_create() {
    n=""
    if [ -f "$title.$type".md ]; then
        n=1
        while [ -f "$title$n.$type".md ]; do
            ((n=n+1))
        done
    fi
    touch "$title$n.$type".md
    echo "# $title" | tr _ " " >> "$title$n.$type".md
}

types=("bullets" "detailed")

case $1 in
    jot)
        title=$(gum input --placeholder "stuff about rocks" | tr " " _)
        echo "note type for $title:"
        type=$(gum choose ${types[@]})
        try_create
        $EDITOR "$title$n.$type".md
        ;;
    new)
        titles=$(gum write --placeholder "more stuff about rocks" | tr " " _)
        for title in $titles; do
            echo "note type for $title:"
            type=$(gum choose ${types[@]})
            try_create
        done
        ;;
    git)
        if [ $(git rev-parse --is-inside-work-tree) ]; then
            git add .
            git commit -q -m "keeping things synced for free!"
            git push -q -u origin master
            echo "Git repo is now up-to-date!"
        else
            git init -q
            echo "To setup syncing:"
            echo " 1. Create a repo on github.com."
            echo " 2. Grab the ssh key [git@github.com:username/reponame.git]."
            echo " 3. run [git remote add origin git@github.com:username/reponame.git]."
        fi
        ;;
    *) 
        echo "Need help?"
        echo " jot = create new note and edit"
        echo " new = create a bunch of notes"
        echo " git = keep your notes synced with a git repo"
        ;;
esac

