#!/bin/bash

# modify unattend files
while read file; do
    sed --in-place -E 's/en-US/it-IT/g' $file
    sed --in-place -E 's#<TimeZone>.*</TimeZone>#<TimeZone>W. Europe Standard Time</TimeZone>#' $file
    sed --in-place -E 's#<InputLocale>.*</InputLocale>#<InputLocale>it-IT; 0409:00000409</InputLocale>#' $file
done <<<"$( find . -name '*unattend.xml' )"

# add support to customize `VCPUS`, `DISKSIZE`, `MEMORY` and `HEADLESS` through environment variables
jq '.variables.cpus = "{{ env `VCPUS` }}" | .variables.disk_size = "{{ env `DISKSIZE` }}" | .variables.memory = "{{ env `MEMORY` }}" | .variables.headless = "{{ env `HEADLESS` }}"' windows.json | sponge windows.json

# update iso url for it language
sed --in-place -E 's@ (export ISO_URL=".*Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO")@ #\1\n            export ISO_URL="http://download.microsoft.com/download/0/A/4/0A42ABE9-772A-4A4B-B185-A036BA6EE093/14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_IT-IT.ISO"@' build.sh
sed --in-place -E 's@ (export ISO_URL=".*9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO")@ #\1\n            export ISO_URL="http://download.microsoft.com/download/9/E/C/9EC778B5-75BA-45A0-8190-FCBE62F82D37/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_IT-IT-IR3_SSS_X64FREE_IT-IT_DV9.ISO"@' build.sh
sed --in-place -E 's@ (export ISO_URL=".*19043.928.210409-1212.21h1_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_it-it.iso")@ #\1\n            export ISO_URL="https://software-download.microsoft.com/download/sg/444969d5-f34g-4e03-ac9d-1f9786c69161/19044.1288.211006-0501.21h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_it-it.iso"@' build.sh
sed --in-place -E 's/en-us([^.]*)\.iso/it-it\1.iso/' build.sh
