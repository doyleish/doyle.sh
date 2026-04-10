#!/bin/bash
## Ryan Doyle

# Nice, you looked at the code (hopefully) before running it. :twothumbsup:

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

# Re-usable introduction blurb
read -d '#' TEXT_INTRO << EOF
$OCCUPATION currently working $REMOTESTATUS from $LOCATION.  I have
been in enterprise software and infrastructure engineering for the past $years_experience
years.  Strong focus on Linux, cloud, and backend development.  Comfortable
contributing everywhere including application, infrastructure, and tooling.
Deep, ingrained experience in several industries including social media, biotech
(gene sequencing), security, and crypto (Ethereum).  Interest in security and
programming languages.
EOF

# Helper Functions
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

# Text blurb intended for terminal
text(){
    #clear
    cat << EOF
─> $FIRSTNAME $LASTNAME <─
┌──────────────
$(echo "$TEXT_INTRO" | _line_prefixed "│ ")

Experience:
┌──────────────
│ - Staff SWE @ Caldera.xyz ───────────────────────────────────────── 2024 -> Present
│   * RaaS / blockchain infra  * Multi-tenant Kubernetes     * IaC
│   * Workflow development     * Appsec/Opsec
│
│ - Staff SWE @ Panther.io ───────────────────────────────────────────── 2022 -> 2024
│   * CI/Deployment Ownership  * Eng tooling                 * Backend Development
│   * Product Architecture     * IaC
│
│ - DevOps Lead @ ClearLabs ──────────────────────────────────────────── 2021 -> 2022
│   * Hybrid cloud + on-prem   * Kubernetes                  * Deployment automation
│   * Networking               * Cloud GPU workloads         * Hardware and OS
│
│ - Principal Eng @ Imagine (hire #1) ────────────────────────────────── 2019 -> 2021
│   * Backend Development      * AWS Product Infrastructure  * Live in ~6 months
│
│ - Senior SRE @ LinkedIn ────────────────────────────────────────────── 2016 -> 2019
│   * Jobs / Recruiter SRE     * Uptime monitoring           * Product architecture
│
│ - Linux Team @ Michigan Tech ───────────────────────────────────────── 2012 -> 2016
│   * Device management        * RPM/YUM repos + packaging   * Puppet + Satellite

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

# A more detailed resume in markdown
markdown(){
    cat << EOF
# $FIRSTNAME $LASTNAME

### A Brief Introduction
$(echo "$TEXT_INTRO" | _line_prefixed "> ")

## Experience
### Staff Software Engineer @ Caldera.xyz ──────────────── 2024 → Present
> Caldera is an Ethereum blockchain infrastructure provider offering rollups-as-a-service via
> a variety of rollup implementations and technologies.

**Scope**: Greenfield platform engineering for multi-tenant blockchain infrastructure. Kubernetes, IaC, deployment
automation, monitoring, security, and product expansion.

**Impact**
- Owned **IaC** for supported software stacks and supporting services with deep per-stack customization
- Owned Multi-tenant **Kubernetes** clusters hosting hundreds of customers with strong security, tenant isolation, and cost discipline
- **Workflow orchestration** for reliable deployment and operation across customer environments
- Evangelized **security** within engineering. Drove customer infra hardening, key management improvements, and engineering operational security
- Deep **debugging** and targeted fixes in vendored components as needed
- Led **ZKsync** support; first RaaS provider to bring that stack to market

**Tools**: _aws, kubernetes, terraform, helm, temporal, prometheus, grafana, vercel_ and more

**Languages**: _golang, typescript, bash, iac/helm, and a bit of rust_

---

### Staff Software Engineer @ Panther.io ──────────────── 2022 → 2024
> Panther is a cloud-native SIEM for threat detection with hundreds of native integrations and
> customization via Python or no-code rules.

**Scope**: Deployment automation, backend development, and internal tooling for a roughly 80-person engineering org.

**Impact**
- Automated **deployments** for fully-managed, customer-infra-vendor-managed, and fully-customer-owned topologies
- Engineer **tooling**: ephemeral environments, **AWS** access control & SSO, GitOps, containerized builds and artifacts
- Owned **IaC** and platform-adjacent product infra with product backend development for select integrations

**Tools**: _aws, pulumi, airplane, docker, github actions_ and more

**Languages**: _golang, python, bash_

---

### DevOps Lead @ ClearLabs ──────────────── 2021 → 2022
> ClearLabs offers gene sequencing products for public and private sector.
> They engage in whole genome, clinical virology, and food safety testing.

**Scope**: Hybrid on-prem and GCP infrastructure for on-site sequencing and remote data processing.

**Impact**
- Ran **Kubernetes** and supporting infrastructure in **GCP**
- Automated hybrid **deployments** (Jenkins, Python) and **hardware/OS provisioning** (Salt)
- SD-WAN **networking** implementation to support deployment into diverse customer networks
- Integrated bioinformatics pipelines with cloud infrastructure, including GPU-intensive workloads

**Technologies**: _python, gcp, kubernetes, jenkins, oxford nanopore sequencers, cisco meraki, salt_ and more

---

### Principal Engineer @ Imagine Financial ──────────────── 2019 → 2021
> Imagine Financial was a payment processing startup focused on merchant-friendly, lower-fee
> payment routing.

**Scope**: First engineering hire; owned backend and cloud from zero through production launch.

**Impact**
- Owned and developed **product backend** (Go APIs, Postgres) and **AWS** infrastructure end to end
- Shipped production payment processing for live US merchants within six months

**Technologies**: _go, aws, postgres, grpc, ach_

---

### Senior Site Reliability Engineer @ LinkedIn ──────────────── 2016 → 2019
> Jobs and Companies, then Recruiter products at LinkedIn

**Scope**: High-throughput web products: infrastructure design, monitoring and observability ownership,
and incident response.

**Impact**
- Contributed to talent product redesign and legacy Recruiter retirement
- Built Recruiter **uptime** reporting for department initiatives and executive visibility
- Significant **on-call** contribution
- Continuous JVM **monitoring** to guide tuning and performance analysis

**Tools**: _couchbase, oracle, kafka, emberjs_, lots of _custom solutions_

**Languages**: _golang, python, bash, java, scala_

---

### Linux Team @ Michigan Technological University ──────────────── 2012 → 2016
> Linux admininistration at Michigan Tech. Supporting computer labs, faculty/staff desktops,
> school datacenter, and research systems.

**Scope**: Develop standard OS images including packaged software and system configuration

**Impact**
- Packaged free and nonfree software, and operated internal RPM repositories
- Standardized **OS configuration** across diverse hardware via Puppet and Red Hat Satellite/Spacewalk

**Technologies**: _bash, python, RHEL, puppet, rpm/yum, redhat satellite_

## Education
_2012 -> 2016_

Graduated with a $DEGREE from $SCHOOL.

## Contact Info:
**email**: [$EMAIL](mailto:$EMAIL); **linkedin**: [rcdoyle]($LINKEDIN)
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
