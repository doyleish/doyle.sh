#!/bin/bash
## Ryan Doyle

# ===========
# Global Vars
# ===========

FIRSTNAME="Ryan"
LASTNAME="Doyle"
OCCUPATION="Software Engineer"
LOCATION="the San Francisco Bay Area"

LANGUAGES="golang python bash java javascript"
EMAIL="ryan@rdoyle.net"

# ===========
# Intro blurb
# ===========
intro(){
    cat << EOF
Hello, My name is $FIRSTNAME $LASTNAME.
I am a $OCCUPATION currently
working in $LOCATION.
EOF
    echo
    start_unix=1350309600 # Began working in software in 2012
    now_unix=$(date +%s)
    years=$(expr $now_unix - $start_unix)
    for div in 60 60 24 365; do 
        years=$(expr $years / $div)
    done
    # Round off b/c integer math and why not ;)
    years=$(expr $years + 1) 
    
    cat << EOF
I have been working in large-scale software
and web infrastructure for the past $years years.

I am proficient in a large variety of programming 
languages. The ones I prefer most include:
EOF
    for lang in $LANGUAGES; do
        echo " - $lang"
    done
}

# If no args passed, default to intro
if [ $# -eq 0 ]; then
    intro
    exit
fi

"$@"
