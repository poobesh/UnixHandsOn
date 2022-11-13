#! /bin/bash
touch consolidated.text
for card_type_full_name in */; do
    echo "$card_type_full_name"
    cd "$card_type_full_name"
    for issuing_bank in */; do
        echo "$issuing_bank"
        cd "$issuing_bank"
        for card_number in *; do