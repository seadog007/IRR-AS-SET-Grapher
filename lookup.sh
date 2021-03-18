#!/bin/bash

function err(){
	echo "$1" >&2
}

function asset(){
	whois -h whois.radb.net "$1" | grep -oP 'members:\ +\KAS.*' | tr ',' '\n' | tr -d ' ' | while read line
	do
		echo "$(echo "$1" | sed 's/[-:]/_/g')->$(echo "$line" | sed 's/[-:]/_/g')"
		[ -n "$(echo $2 | grep "$1")" ] && err "$1 Abort" && continue
		"$0" "$line" "$2 $1"
	done

}

function as(){
	err "$1"
}


[ -z "$(echo "$1" | grep '^AS[0-9\-]')" ] && err "Not an AS/AS-SET" && exit 1
[ -n "$(echo "$1" | grep '^AS-.*$')" ] || [ -n "$(echo "$1" | grep '^AS[0-9]\+:.*$')" ] && err "$1 AS-SET" && asset "$1" "$2"
[ -n "$(echo "$1" | grep '^AS[0-9]\+$')" ] && err "$1 Normal AS" && as "$1" 
