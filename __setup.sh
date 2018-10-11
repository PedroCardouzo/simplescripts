#!/bin/bash

function __create_or_update_files {	

	if "$2" == 'purge-git'; then
		rm -R "$1"
	else
		if [ -d "$1" ]; then
			cd "$1";
			chmod +x __update.sh;
			./__update.sh "$2";
			cd ../;
		else
			git clone "https://""$KEY""@github.wdf.sap.corp/I866021/""$1"".git";
		fi
	fi
}

function get_version {
	echo "$(cat ~/.toolversion)";
}

function set_version {
	echo "$1" >  ~/.toolversion;
}

function is_lower_version {
	if [ "$(get_version)" -lt "$1" ]; then
		set_version "$1";
		true # sets $? to 0
	else
		false # sets $? to 1
	fi
}

usage="setup [-h -d -p] -- update the integration tool
where:
    -h  show this help text
    -d  get dev branch (if any)
    -p  purge git data
"

while getopts 'hdp' OPT; do
  case "$OPT" in
    'h') echo "$usage"
       exit
       ;;
    'd') ARG='-d';
       ;;
    'p') ARG='purge-git'
 	   ;;
    '?') printf "illegal option: -%s\n" "$0" >&2
       echo "$usage" >&2
       exit -1
       ;;
  esac
done


if ! [ -f '~/.toolversion' ]; then
	echo '0' > ~/.toolversion;
fi


if is_lower_version 1; then 
	CERTIFICATE_FOLDER=~/git_cert
	CERTIFICATE_FILE='"$CERTIFICATE_FOLDER"/sap-git.crt'
	if ! [ -f "$CERTIFICATE_FILE" ]; then
		mkdir -p "$CERTIFICATE_FOLDER"
		touch "$CERTIFICATE_FILE"
	fi

cat >"$CERTIFICATE_FILE" <<EOL
-----BEGIN CERTIFICATE-----
MIIGBDCCA+ygAwIBAgIDAa82MA0GCSqGSIb3DQEBCwUAMEQxCzAJBgNVBAYTAkRF
MREwDwYDVQQHDAhXYWxsZG9yZjEMMAoGA1UECgwDU0FQMRQwEgYDVQQDDAtTQVBO
ZXRDQV9HMjAeFw0xODA2MTQxNzE1MzlaFw0yMDA2MTQxNzE1MzlaMGQxCzAJBgNV
BAYTAkRFMQwwCgYDVQQKEwNTQVAxKTAnBgNVBAsTIENMTSBDTSBJbmZyYXN0cnVj
dHVyZSBBdXRvbWF0aW9uMRwwGgYDVQQDExNnaXRodWIud2RmLnNhcC5jb3JwMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6nePSgb3kdCMn9EShpz2Q2Ar
1RzeXQQNbJ02hPNIjYZH3dqqW4STUVvoBSjBk8I/CKS/xB2uW0cKgjDVbQhyxct4
4QIvhXSS4jtRw6XZwXugXLB1K17fLygY1yBbFJXu+0M0HlROjTpzkpKUzN2ieB10
LlaorLTG6uFeIz78duA3iVSnFdCEYRC1tPaWKOojUiz2LG36/7L+zKbJnjJPg7z5
CicGfSCr9ZJ4CUKIMV7D/EInMcV0O0YCFuardVEWvj5/cGjyONL5r6lp/cpz7OaC
pQudd0vx0YBCTVPNb1Kh5wYfYzI59fORHG0DtXHSgHrNQthBA65jEUbvnAVaLQID
AQABo4IB3TCCAdkwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMB8GA1Ud
IwQYMBaAFDgkr411Evw4PzeDEK+QPPwbIVr/MEkGCCsGAQUFBwEBBD0wOzA5Bggr
BgEFBQcwAoYtaHR0cDovL2FpYS5wa2kuY28uc2FwLmNvbS9haWEvU0FQTmV0Q0Ff
RzIuY3J0MIHfBgNVHR8EgdcwgdQwgdGggc6ggcuGLWh0dHA6Ly9jZHAucGtpLmNv
LnNhcC5jb20vY2RwL1NBUE5ldENBX0cyLmNybIaBmWxkYXA6Ly8vQ049U0FQTkVU
Q0FHMiwgQ049U0FQTkVUQ0FHMiwgQ049Q0RQLCBDTj1QdWJsaWMgS2V5IFNlcnZp
Y2VzLCBDTj1TZXJ2aWNlcywgQ049Q29uZmlndXJhdGlvbiwgREM9Z2xvYmFsLCBE
Qz1jb3JwLCBEQz1zYXA/Y2VydGlmaWNhdGVyZXZvY2F0aW9ubGlzdDARBgNVHQ4E
CgQIRCsix1013MAwDgYDVR0PAQH/BAQDAgWgMDkGA1UdEQQyMDCCE2dpdGh1Yi53
ZGYuc2FwLmNvcnCBGUQwNjQ5MzVAZXhjaGFuZ2Uuc2FwLmNvcnAwDAYDVR0TAQH/
BAIwADANBgkqhkiG9w0BAQsFAAOCAgEAdeU65qhqZv5vGwjpYdGcvR99S0Wbys9v
OqrgAfN8iW/h/LthiNdmttspOYGvoOh0wPs8CWEzCaq6VwUtFTb31p8AxZWGgO8j
LY40DdZ7QSOwJfYAH9CgElOiTn0pOXvjvAjrgD5qsCAemoYKue2prWH9Z4V0WJUb
CcaGzsXVoVUSRTjmycL0IxlRYWEF/fRu7As2EHNhwwQaTa5OQWXNYmBM4NSXSCMa
tpgZxRAD5FHr960wuuq9/IkFBU4rPz1eoFpml8GRxaWdeQlECojT6f0RPQBBOLHp
Q2eznySYU8zvhQzw45SsRYwdL5QkLW+UdlDvLRZdfkUc/daNeLeDFBnNPPv/+9/S
YUWWXJ2Zouk3DKlzViQgv+hV2x/XwA1uczbE2OsH0aDr1vs5u493ObBpR5cjHaAy
jz0GVW5hnL5kerSv2U9fGuKm0lMq2wmP8ZiT65066airzK/+2P07sIau41h6P019
iOq/vg9pG47HZjB1kYUZxCi72et71Iek1WCEGmXnEDFyiLCtrv8rARd3AtZfUG2c
amHswaVjSUxvh/ooUDMcgv+PGWdCADqwm8I/lOTcAPHlKYWD3Rg3lgaUa/pjSyhi
cpaqHFoSlEC68d3YlWGg/c31ouUjRST/udV10eCacK7KsDbwzu+9fiFYqU/1PTWN
+WVOzt3zy1k=
-----END CERTIFICATE-----
EOL

	git config --global http.sslCAInfo "$CERTIFICATE_FILE"

fi


__create_or_update_files "simplescripts" "$ARG";
__create_or_update_files "xml_decoder" "$ARG";
__create_or_update_files "xml_extractor" "$ARG";