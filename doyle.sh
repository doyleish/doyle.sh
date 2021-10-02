#!/bin/bash
## Ryan Doyle

# ===========
# Global Vars
# ===========
FIRSTNAME="Ryan"
LASTNAME="Doyle"
OCCUPATION="Infrastructure and Software Engineer"
LOCATION="the San Francisco Bay Area"

LANGUAGES="terraform golang python bash typescript postgresql"
EMAIL="ryan@rdoyle.net"

# ===============
# Calculated Vars
# ===============
start_unix=1350309600 # Began working in software in 2012
now_unix=$(date +%s)
years=$(expr $now_unix - $start_unix)
for div in 60 60 24 365; do
    years=$(expr $years / $div)
done
# Round off b/c integer math and why not ;)
years=$(expr $years + 1)

# Because occupation names change and English is silly
article="" && [[ $OCCUPATION == @("A"|"E"|"I"|"O"|"U")* ]] && article="an" || article="a"

# ===========
# Intro blurb
# ===========
intro(){
    clear
    echo
    cat << EOF
   ______              __            __
  / ____ \\   _________/ /___  __  __/ /__
 / / __ \\/  / ___/ __  / __ \\/ / / / / _ \\
/ / /_/ /  / /  / /_/ / /_/ / /_/ / /  __/
\ \\__,_/  /_/   \\__,_/\\____/\\__, /_/\\___/
 \\____/                    /____/
EOF
	echo
    cat << EOF
Hello, My name is $FIRSTNAME.
I am $article $OCCUPATION currently
working in $LOCATION.
EOF
    echo

    cat << EOF
I have been working in large-scale software and web infrastructure
for the past $years years.  I'm an avid supporter of open-source
development and am particularly interested in DevOps and dev strategies
in general.

I am proficient in a variety of programming languages and tools. The ones I
favor most include:
EOF
    for lang in $LANGUAGES; do
        echo " - $lang"
    done
    echo

    cat << EOF
And finally some unsolicited advice:
1. Don't blindly run random scripts you find on the internet (shame 🔔).
2. Avoid turning your workstation into critical infra.
3. Automate anything and everything.

https://rdoyle.net
EOF
    echo;echo
}

# If no args passed, default to intro
if [ $# -eq 0 ]; then
    intro
    exit
fi
