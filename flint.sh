#!/bin/bash

createNote() {
    echo "note type for $TITLE:"
    TYPE=$(gum choose "bullets" "detailed")
    touch "$TITLE.$TYPE".md
}

case $1 in
    jot)
        TITLE=$(gum input --placeholder "stuff about rocks" | tr " " _)
        createNote
        echo "# $TITLE" | tr _ " " >> "$TITLE.$TYPE".md
        $EDITOR "$TITLE.$TYPE".md
        ;;
    new)
        TITLES=$(gum write --placeholder "more stuff about rocks" | tr " " _)
        for TITLE in $TITLES
        do
            createNote
            echo "# $TITLE" | tr _ " " >> "$TITLE.$TYPE".md
        done
        ;;
    git)
        if [ $(git rev-parse --is-inside-work-tree) ]
        then
            git add .
            git commit -q -m "keeping things synced for free!"
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
        echo " git = keep your notes synced with a git repo"
        ;;
esac

