## Introduction

Vulnscan is a module which enhances nmap to a vulnerability scanner. The nmap option -sV enables version detection per service which is used to determine potential flaws according to the identified product. The data is looked up in an offline version of VulDB.

## Installation

Please install the files into the following folder of your Nmap installation:

    Nmap\scripts\vulnscan\*

Clone the GitHub repository like this:

    git clone https://github.com/khulnasoft-lab/vulnscan khulnasoft_vulnscan
    ln -s `pwd`/khulnasoft_vulnscan /usr/share/nmap/scripts/vulnscan

## Usage

You have to run the following minimal command to initiate a simple vulnerability scan:

    nmap -sV --script=vulnscan/vulnscan.nse www.example.com

## Vulnerability Database

There are the following pre-installed databases available at the moment:

* scipvuldb.csv - https://vuldb.com
* cve.csv - https://cve.mitre.org
* securityfocus.csv - https://www.securityfocus.com/bid/
* xforce.csv - https://exchange.xforce.ibmcloud.com/
* expliotdb.csv - https://www.exploit-db.com
* openvas.csv - http://www.openvas.org
* securitytracker.csv - https://www.securitytracker.com (end-of-life)
* osvdb.csv - http://www.osvdb.org (end-of-life)

## Single Database Mode

You may execute vulnscan with the following argument to use a single database:

    --script-args vulnscandb=your_own_database

It is also possible to create and reference your own databases. This requires to create a database file, which has the following structure:

    <id>;<title>

Just execute vulnscan like you would by refering to one of the pre-delivered databases. Feel free to share your own database and vulnerability connection with me, to add it to the official repository.

## Update Database

The vulnerability databases are updated and assembled on a regularly basis. To support the latest disclosed vulnerabilities, keep your local vulnerability databases up-to-date.

To automatically update the databases, simply set execution permissions to the `update.sh` file and run it:

    chmod 744 update.sh
    ./update.sh

If you want to manually update your databases, go to the following web site and download these files:

* https://khulnasoft-lab.github.io/vulnscan/download/cve.csv
* https://khulnasoft-lab.github.io/vulnscan/download/exploitdb.csv
* https://khulnasoft-lab.github.io/vulnscan/download/openvas.csv
* https://khulnasoft-lab.github.io/vulnscan/download/osvdb.csv
* https://khulnasoft-lab.github.io/vulnscan/download/scipvuldb.csv
* https://khulnasoft-lab.github.io/vulnscan/download/securityfocus.csv
* https://khulnasoft-lab.github.io/vulnscan/download/securitytracker.csv
* https://khulnasoft-lab.github.io/vulnscan/download/xforce.csv

Copy the files into your vulnscan folder:

    /vulnscan/

## Version Detection

If the version detection was able to identify the software version and the vulnerability database is providing such details, also this data is matched.

Disabling this feature might introduce false-positive but might also eliminate false-negatives and increase performance slighty. If you want to disable additional version matching, use the following argument:

    --script-args vulnscanversiondetection=0

Version detection of vulnscan is only as good as Nmap version detection and the vulnerability database entries are. Some databases do not provide conclusive version information, which may lead to a lot of false-positives (as can be seen for Apache servers).

## Match Priority

The script is trying to identify the best matches only. If no positive match could been found, the best possible match (with might be a false-positive) is put on display.

If you want to show all matches, which might introduce a lot of false-positives but might be useful for further investigation, use the following argument:

    --script-args vulnscanshowall=1

## Interactive Mode

The interactive mode helps you to override version detection results for every port. Use the following argument to enable the interactive mode:

    --script-args vulnscaninteractive=1

## Reporting

All matching results are printed one by line. The default layout for this is:

    [{id}] {title}\n

It is possible to use another pre-defined report structure with the following argument:

    --script-args vulnscanoutput=details
    --script-args vulnscanoutput=listid
    --script-args vulnscanoutput=listlink
    --script-args vulnscanoutput=listtitle

You may enforce your own report structure by using the following argument (some examples):

    --script-args vulnscanoutput='{link}\n{title}\n\n'
    --script-args vulnscanoutput='ID: {id} - Title: {title} ({matches})\n'
    --script-args vulnscanoutput='{id} | {product} | {version}\n'

Supported are the following elements for a dynamic report template:

* {id} - ID of the vulnerability
* {title} - Title of the vulnerability
* {matches} - Count of matches
* {product} - Matched product string(s)
* {version} - Matched version string(s)
* {link} - Link to the vulnerability database entry
* \n - Newline
* \t - Tab

Every default database comes with an url and a link, which is used during the scanning and might be accessed as {link} within the customized report template. To use custom database links, use the following argument:

    --script-args "vulnscandblink=http://example.org/{id}"

## Disclaimer

Keep in mind that this kind of derivative vulnerability scanning heavily relies on the confidence of the version detection of nmap, the amount of documented vulnerabilities and the accuracy of pattern matching. The existence of potential flaws is not verified with additional scanning nor exploiting techniques.
