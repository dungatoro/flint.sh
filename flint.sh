#!/bin/bash

tryCreate() {
    N=""
    if [ -f "$TITLE.$TYPE".md ]
    then
        N=1
        while [ -f "$TITLE$N.$TYPE".md ]
        do
            N+=1
        done
    fi
    touch "$TITLE$N.$TYPE".md
    echo "# $TITLE" | tr _ " " >> "$TITLE$N.$TYPE".md
}

TYPES=("bullets" "detailed")

case $1 in
    jot)
        TITLE=$(gum input --placeholder "stuff about rocks" | tr " " _)
        echo "note type for $TITLE:"
        TYPE=$(gum choose ${TYPES[@]})
        tryCreate
        $EDITOR "$TITLE$N.$TYPE".md
        ;;
    new)
        TITLES=$(gum write --placeholder "more stuff about rocks" | tr " " _)
        for TITLE in $TITLES
        do
            echo "note type for $TITLE:"
            TYPE=$(gum choose ${TYPES[@]})
            tryCreate
        done
        ;;
    all)

        ;;
    git)
        if [ $(git rev-parse --is-inside-work-tree) ]
        then
            git add .
            git commit -q -m "keeping things synced for free!"
            git push -q
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

