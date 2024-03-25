#!/bin/bash

log_file="image.log"
decryption_file="decrypted.txt"
link_file="link.txt"
secret_image_file="secret_image.jpg"

current_datetime=$(date +"%d/%m/%y %H:%M:%S")

for file in genshin_character/*/*.jpg
do
  steghide extract -sf "$file" -xf encrypt.txt -p ""
  decrypt=$(cat encrypt.txt | base64 -d 2>/dev/null)
  echo "$decrypt" > "$decryption_file"

  if [[ "$decrypt" == *"http"* ]]
  then
    echo "$decrypt" > "$link_file"

    wget -O "$secret_image_file" "$decrypt"
    echo "[$current_datetime] [FOUND] [$file]" >> "$log_file"
    echo -e "\nSecret image downloaded from $decrypt and saved as $secret_image_file"
    break
  else
    echo "[$current_datetime] [NOT FOUND] [$file]" >> "$log_file"
  fi

  rm encrypt.txt
  if [ -f "$decryption_file" ]; then
    rm "$decryption_file"
  fi

  sleep 1
done

rm decrypted.txt
rm encrypt.txt
