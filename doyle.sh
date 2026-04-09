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
DEGREE="Bachelor's in Computer Science"
SCHOOL="Michigan Technological University"

LANGUAGES="golang python rust bash js/ts +more"
TECH="linux kubernetes aws gcp terraform temporal ethereum +more"

EMAIL="ryan@rdoyle.net"
WEBSITE="https://rdoyle.net"
LINKEDIN="https://linkedin.com/in/rcdoyle"

start_unix=1350309600 # Began this stuff as a job in 2012. Tinkering since ~2007.
now_unix=$(date +%s)
years_experience=$(bc <<< "scale=2; ($now_unix-$start_unix)/31536000")

read -d '#' TEXT_INTRO << EOF
$OCCUPATION currently working $REMOTESTATUS from $LOCATION.
I have been in large-scale software engineering and infrastructure for the 
past $years_experience years.  Strong focus on Linux, cloud, and backend application 
development. Fluent enough to contribute all over including application,
infrastructure, and tooling.  Deep, ingrained experience in several
industries including social media, biotech (gene sequencing), security,
and crypto (Ethereum).  Big into security and programming languages.
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

_line_prefixed(){
    while read line; do
        echo "$1 $line"
    done
}

_markdown_list(){
    for word in $@; do
        echo "- $word"
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
$(echo "$TEXT_INTRO" | _line_prefixed "│ ")

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
EOF
}

markdown(){
    cat << EOF
# $FIRSTNAME $LASTNAME

---

### A Brief Introduction

$(echo "$TEXT_INTRO" | _line_prefixed "> ")

---

## Experience

### Staff Software Engineer @ Caldera.xyz

_2024 -> Present_, Caldera is an Ethereum infrastructure provider primarily offering Ethereum rollups
as a service.

**Responsibilities** involve leading the greenfield development of several areas of the company relating
to managing blockchain infrastructure in a multi-tenant environment.  Focusing on providing infrastructure
as a service via IaC, deployment automation, monitoring, security, and all around backend engineering.

**Notable projects** include

- Infrastructure-as-code implementation for supported blockchain software stacks and supporting
  infrastructure; providing deep customizability for the different stacks supported by the product.
- Kubernetes implementation as a multi-tenant environment, hosting hundreds of customers in a secure
  and cost-effective manner
- Implementing workflow orchestration to accurately and easily deploy and operate customer infrastructure
- Evangelizing security topics in the engineering team and leading several efforts both in securing
  customer infra, key management, and operational security within engineering
- Deeply debugging vendored software and focused contributions where necessary
- Leading development on support for ZKsync; bringing us to market as the first RaaS provider to support it

**Tools and tech** leveraged include _aws, kubernetes, terraform, helm, temporal, prometheus, grafana,
  vercel_ and more.

**Languages** utilized the most here are _golang, typescript, bash, iac/helm, and a bit of rust_

---

### Staff Software Engineer @ Panther.io

_2022 -> 2024_, Panther is a cloud-native SIEM product for advanced detection of security threats
from hundreds of native integrations, and fully customizable through python or no-code options.

**Responsibilities** involved primarily automating deployments and supporting a roughly 80-strong
engineering team with tooling for testing, access, and deployment.

**Notable projects** included

- Automating product deployment in several configurations including fully managed,
  customer-owned-vendor-managed, and customer-owned-and-managed configurations
- Significant strides in engineer tooling like ephemeral deployments, AWS access control, gitops,
  containerizing builds and artifacts, and more.
- Ownership over infra-related parts of product development like IaC, with some outright app backend
  development for certain integrations.

**Tools and tech** leveraged include _aws, pulumi, airplane, docker, github actions_ and more.

**Languages** utilized the most here were _golang, python, and bash_

---

### DevOps Lead @ ClearLabs

_2021 -> 2022_,  ClearLabs offers a next-generation gene-sequencing solution for private and public
sector use.  Automating whole genome sequencing, clinical virology sequencing, and food safety testing.

**Responsibilities** involved primarily developing and automating hybrid on-prem and cloud infrastructure.

**Notable projects** included

- Managing kubernetes and supporting infrastructure in GCP
- Automating product deployments to hybrid cloud/on-prem targets via jenkins and python,
  and hardware/OS provisioning via salt
- Developing local networking solution to fit product behind all variety of firewalls, leveraging SD-WAN
- Integrating bioinformatics pipelines into cloud infra (heavy gpu workloads, etc)

**Tools and tech** leveraged include _gcp, kubernetes, jenkins, oxford nanopore sequencers, cisco
  meraki_ and more.

---

### Principal Engineer @ Imagine Financial

_2019 -> 2021_, Imagine was a payment-processing startup aimed at merchant friendliness through
lower-fee payment routing. 

Employee #1.  Led development of product backend in golang including api and db, as well as
cloud infrastructure in aws. **Notably** achieving a launched, functional product processing payments in
the US for live merchants in 6 months.

**Tools and tech** leveraged include _aws, postgres, grpc, ach_

---

### Senior Site Reliability Engineer @ LinkedIn

_2016 -> 2019_, Engineer on the Jobs and Companies products, and then later on the Recruiter product at LinkedIn

**Responsibilities** involved developing robust infrastructure for extremely high-throughput web products.
Also bettering observability and monitoring of those products and supporting them on-call.

**Notable projects** included

- Helped designing a new iteration of the larger talent product and sunsetting the legacy recruiter product
- Fully custom uptime reporting tool for recruiter, used to drive department efforts and exec reporting
- Novel dashboard generating utility for engineering use
- JVM continuous monitoring to drive tuning and analysis

**Tools and tech** leveraged include _couchbase, oracle, kafka, emberjs, and lots of custom solutions_

**Languages** utilized the most here were _golang, python, bash, java, scala_

---

### Linux Team @ Michigan Technological University

_2012 -> 2016_, The linux team was responsible for the OS installation, software suite, and deployment
throughout campus labs, offices, and research environments.

**Responsibilities** involved packaging a variety of free and nonfree applications, managing internal RPM
repositories for those packages, configuring the OS on a variety of hardware via puppet and redhat
satellite/spacewalk

**Tools and tech** leveraged include _RHEL, puppet, rpm/yum, redhat satellite_

---

### Various other positions

- Contract consulting
- IT Helpdesk @ Michigan Tech
- IT Intern @ Asahi Kasei Plastics NA

---

## Education

_2012 -> 2016_

Graduated with a $DEGREE from $SCHOOL

---

## Contact Info:
**email**: [$EMAIL](mailto:$EMAIL) ; **linkedin**: [rcdoyle]($LINKEDIN)
EOF
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
    echo
    echo "Don't run random scripts you find on the internet (shame 🔔)."
    exit
fi

$1
