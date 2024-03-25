#!/bin/bash
wget -O genshin.zip 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
unzip genshin.zip 

unzip genshin_character.zip


for encrypted_file in  genshin_character/*
  do
    filename=$(basename -- "$encrypted_file")
    filename="${filename%.*}"
    decoded_filename=$(echo "$filename" | xxd -r -p)
    mv "$encrypted_file" "genshin_character/$decoded_filename"
  done

csv_file="./list_character.csv"

character_dir="./genshin_character"

tail -n +2 "$csv_file" | while IFS=',' read -r name region element weapon
do
    if [ ! -d "$character_dir/$region" ]; then
        mkdir "$character_dir/$region"
    fi

    file_name="$region - $name - $element - $weapon.jpg"
    file_name=$(echo "$file_name" | tr -d '\r')

    find "$character_dir" -type f -iname "*$name*" -exec mv {} "$character_dir/$region/$file_name" \;
done

declare -A weapon_count

for file in "$character_dir"/*/*.jpg
do
    weapon=$(echo "$file" | awk -F ' - ' '{print $NF}' | sed 's/.jpg//')

    ((weapon_count["$weapon"]++))
done

echo "Bow      : ${weapon_count[Bow]}"
echo "Sword    : ${weapon_count[Sword]}"
echo "Claymore : ${weapon_count[Claymore]}"
echo "Catalyst : ${weapon_count[Catalyst]}"
echo "Polearm  : ${weapon_count[Polearm]}"

rm genshin_character.zip 
rm list_character.csv 
rm genshin.zip
