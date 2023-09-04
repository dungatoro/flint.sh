#!/bin/bash

case $1 in
    jot)
        TITLE=$(gum input --placeholder "stuff_about_rocks" | tr " " _)
        echo "note type for $TITLE:"
        TYPE=$(cat types | gum choose)
        touch "$TITLE.$TYPE".md
        $EDITOR "$TITLE.$TYPE".md
        ;;
    new)
        TITLES=$(gum write --placeholder "more_stuff_about_rocks" | tr " " _)
        for TITLE in $TITLES
        do
            echo "Type for $TITLE:"
            TYPE=$(cat types | gum choose)
            touch "$TITLE.$TYPE".md
        done
        ;;
    del)
        FILES=$(ls -R | gum choose --no-limit)
        gum confirm "Delete files?" &&
        for F in $FILES 
        do
            rm "$F"
        done
        ;;
    git)
        if [ $(git rev-parse --is-inside-work-tree) ]
        then
            git add . -q
            git commit -m "keeping things synced for free!"
            git push -u origin master
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
        echo " del = select some useless notes and delete"
        ;;
esac

