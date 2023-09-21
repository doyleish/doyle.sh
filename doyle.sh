#!/bin/bash
## Ryan Doyle
# ===========
# Global Vars
# ===========
FIRSTNAME="Ryan"
LASTNAME="Doyle"
OCCUPATION="DevOps Engineer"
LOCATION="the Denver area"
REMOTESTATUS="fully remote"

LANGUAGES="python bash golang sql js etc..."
TECH="aws gcp kubernetes cd iac network"

EMAIL="ryan@rdoyle.net"
WEBSITE="https://rdoyle.net"
LINKEDIN="https://linkedin.com/in/rcdoyle"

COLUMNS=3

# ================
# Helper Functions
# ================
_table(){
    columns=$1
    shift 1
    offset=$1
    shift 1
    wordlist=$@

    column_width=0
    for word in $wordlist; do
        wordlen=$(echo -n $word | wc -c)
        [ $wordlen -gt $column_width ] && column_width=$wordlen
    done
    column_width=$(expr $column_width + $offset)

    index=0
    for word in $wordlist; do
        [ $(expr $index % $columns) -eq 0 ] && echo -n "│ "
        wordlen=$(echo -n $word | wc -c)
        padding=$(expr $column_width - $wordlen)
        echo -n $word
        for x in $(seq 1 $padding); do echo -n " "; done
        index=$(expr $index + 1)
        [ $(expr $index % $columns) -eq 0 ] && echo
    done
    [ $(expr $index % $columns) -ne 0 ] && echo
}

# ===============
# Calculated Vars
# ===============
start_unix=1350309600 # Began working in software in 2012
now_unix=$(date +%s)
years_experience=$(awk "BEGIN {printf \"%0.2f\", ($now_unix-$start_unix)/31536000}")

# ===========
# Intro blurb
# ===========
intro(){
    #clear
    cat << EOF
______________
# Ryan Doyle #  $OCCUPATION currently working $REMOTESTATUS from $LOCATION
‾‾‾‾‾‾‾‾‾‾‾‾‾‾
About:
┌──────────────
│ I have been in large-scale software and web infrastructure for 
│ the past $years_experience years. I love rock-solid software architecture.

Experience:
┌──────────────
│ - Automation Team @ Panther Labs ──────────────────────────────────── 2022 -> Present
│   * Product Architecture   * IaC implementation       * CI implementation
│   * Developer tools        * Deployment automation
│
│ - DevOps Lead @ Clear Labs ────────────────────────────────────────── 2021 -> 2022
│   * IaC implementation     * Deployment automation    * Hybrid onPrem/cloud
│   * Hiring and PM          * Monitoring               * Configuration management
│
│ - Principal Eng (Employee 1) @ Imagine Financial ──────────────────── 2019 -> 2021
│   * Backend development    * Cloud infra development  * Security
│   * Hiring                 * Functional, launched product in 6 months
│
│ - Senior Site-Reliability-Engineer @ LinkedIn ─────────────────────── 2016 -> 2019
│   * 'Recruiter' product    * Monitoring development   * Containerization
│   * Infrastructure design  * On-Call rotation         * Hiring
│
│ - Linux Team @ MTU ────────────────────────────────────────────────── 2012 -> 2015
│   * Device management      * Spacewalk, Puppet admin  * RPM/YUM software packaging

Tools and Tech:
┌──────────────
$(_table 3 -3 $TECH)

Languages:
┌──────────────
$(_table 3 1 $LANGUAGES)

Education:
┌──────────────
│ * BA in CS from Michigan Technological University

Contact Info:
┌──────────────
│ $EMAIL
│ $WEBSITE
│ $LINKEDIN

Don't run random scripts you find on the internet (shame 🔔).
EOF
    echo
}

setup(){
    set -e
    echo "Looks like you've stumbled upon the dotfile setup..."
    echo -n "Where would you like to clone the config package into? [$HOME/.rdconfig]: "
    read SETUP_PATH
    if [ -z "$SETUP_PATH" ]; then
        SETUP_PATH=$HOME/.rdconfig
    fi

    git clone https://gitlab.com/rdoyle/config.git $SETUP_PATH
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

# If no args passed, default to intro
if [ $# -eq 0 ]; then
    intro
    exit
fi

$1
