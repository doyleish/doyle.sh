#!/bin/bash
## Ryan Doyle

# Nice, you looked at the code you were running (hopefully) before running it. :twothumbsup:

# ===========
# The Basics
# ===========
FIRSTNAME="Ryan"
LASTNAME="Doyle"
OCCUPATION="Software Engineer"
LOCATION="the United States"
REMOTESTATUS="fully remote"
DEGREE="Bachelors, Computer Science"
SCHOOL="Michigan Technological University"

LANGUAGES="golang python rust bash js/ts +more"
TECH="linux kubernetes aws gcp terraform temporal ethereum +more"

EMAIL="ryan@rdoyle.net"
WEBSITE="https://rdoyle.net"
LINKEDIN="https://linkedin.com/in/rcdoyle"

start_unix=1350309600 # Began this stuff as a job in 2012. Tinkering since ~2007.
now_unix=$(date +%s)
years_experience=$(bc -S 2 <<< "($now_unix-$start_unix)/31536000")

read -d '#' TEXT_INTRO << EOF
$OCCUPATION currently working $REMOTESTATUS from $LOCATION.
I have been in large-scale software and web infrastructure for the past $years_experience years.
Specializing in DevOps, but fluent enough to contribute all across the backend,
from OS to Application.  Deeply ingrained experience in several industries
including social media, biotech(gene sequencing), security, and crypto(ethereum).
EOF

# ================
# Helper Functions
# ================
_table(){
    # some sections can be built as tables as they are updated more frequently.
    columns=$1
    shift 1
    padding=$1
    shift 1
    row_prefix=$1
    shift 1
    wordlist=$@

    column_width=0
    for word in $wordlist; do
        wordlen=$(wc -c <<< "$word")
        [ $wordlen -gt $column_width ] && column_width=$wordlen
    done
    column_width=$(bc <<< "$column_width + $padding")

    index=0
    for word in $wordlist; do
        [ $(bc <<< "$index % $columns") -eq 0 ] && echo -n "$row_prefix"
        wordlen=$(echo -n $word | wc -c)
        padding=$(bc <<< "$column_width - $wordlen")
        echo -n $word
        for x in $(seq 1 $padding); do echo -n " "; done
        index=$(bc <<< "$index + 1")
        [ $(bc <<< "$index % $columns") -eq 0 ] && echo
    done
    [ $(bc <<< "$index % $columns") -ne 0 ] && echo
}

_vert_line_prefixed(){
    while read line; do
        echo "│ $line"
    done
}

# ===========
# text blurb
# ===========
text(){
    #clear
    cat << EOF
─> $FIRSTNAME $LASTNAME <─
┌──────────────
$(echo "$TEXT_INTRO" | _vert_line_prefixed)

Experience:
┌──────────────
│ - Staff SWE @ Caldera ──────────────────────────────────────────────── 2024 -> Present
│   * Multi-tenant infra     * IaC implementation       * Appsec + Opsec
│   * Deployment automation  * Kubernetes (cluster arch, lifecycle, updates, etc)
│
│ - Staff SWE @ Panther Labs ─────────────────────────────────────────── 2022 -> 2024
│   * Product Architecture   * IaC implementation       * CI implementation
│   * Developer tools        * Deployment automation    * App Dev
│
│ - DevOps Lead @ Clear Labs ─────────────────────────────────────────── 2021 -> 2022
│   * IaC implementation     * Deployment automation    * Hybrid onPrem/cloud
│
│ - Principal Eng (Employee 1) @ Imagine Financial ───────────────────── 2019 -> 2021
│   * Backend & Infra dev    * Functional, launched product in 6 months
│
│ - Senior SRE @ LinkedIn ────────────────────────────────────────────── 2016 -> 2019
│   * 'Recruiter' product    * Monitoring development   * Infrastructure design
│
│ - Linux Team @ Michigan Technological University ───────────────────── 2012 -> 2015
│   * Device management      * Spacewalk, Puppet admin  * RPM/YUM packaging

Tools and Tech:
┌──────────────
$(_table 4 1 "│ " $TECH)

Languages:
┌──────────────
$(_table 3 2 "│ " $LANGUAGES)

Education:
┌──────────────
│ $DEGREE from $SCHOOL

Contact Info:
┌──────────────
│ e: $EMAIL
│ li: $LINKEDIN

Don't run random scripts you find on the internet (shame 🔔).
EOF
}

markdown(){
    echo "Not implemented..."
}

latex(){
    echo "Not implemented..."
}

html(){
    echo "Not implemented..."
}

pdf(){
    echo "Not implemented..."
}

# Some extra fns that are probably not useful to anyone but myself
setup(){
    set -e
    echo "Looks like you've stumbled upon the dotfile setup..."
    echo -n "Where would you like to clone the config package into? [$HOME/.rdconfig]: "
    read SETUP_PATH
    if [ -z "$SETUP_PATH" ]; then
        SETUP_PATH=$HOME/.rdconfig
    fi

    git clone https://github.com/doyleish/config.git $SETUP_PATH
    echo -n "Config cloned! Would you like to run the setup? [Y/n]: "
    read CHOICE
    if [ ! -z "$CHOICE" ] && [ ! "CHOICE" == "Y" ] && [ ! "CHOICE" == "y" ]; then
        echo "Goodbye!"
        return 0
    fi
    cd $SETUP_PATH
    ./setup
    echo "Setup Done!"
}

# If no args passed, default to text intro
if [ $# -eq 0 ]; then
    text
    exit
fi

$1
