#!/bin/bash

while read file; do
    sed --in-place -E 's/en-US/it-IT/g' $file
    sed --in-place -E 's#<TimeZone>.*</TimeZone>#<TimeZone>W. Europe Standard Time</TimeZone>#' $file
    sed --in-place -E 's#<InputLocale>.*</InputLocale>#<InputLocale>it-IT; 0409:00000409</InputLocale>#' $file
done <<<"$( find . -name '*unattend.xml' )"

