#!/bin/bash

# Mengecek apakah email sudah terdaftar
cek_email() {
    if grep -q "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt; then
        echo "Email $email already registered. Please choose another one!"
        echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER FAILED] ERROR Failed register email [$email] already registered." >> /home/ash23/Downloads/soalsisop/users/auth.log 
        exit 1
    fi
}

# Meminta input dari pengguna
echo "Welcome to Registration System"
echo "Enter your email:" 
read email
cek_email "$email"
echo "Enter your username:"
read username
echo "Enter a security question:"
read question
echo "Enter the answer to your security question:"
read answer 
read -s -p "Enter a password (minimum 8 Characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same username, birthdate, or name):" password
echo

# Cek apakah email mengandung kata admin
if [[ $email == *admin* ]]; then
    unique="admin"
else
    unique="user"
fi

# Validasi password
if [[ ${#password} -lt 8 || ! "$password" =~ [[:lower:]] || ! "$password" =~ [[:upper:]] || ! "$password" =~ [[:digit:]] || ! "$password" =~ [[:punct:]] ]]; then
    echo "passwords do not meet security criteria!"
    echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER FAILED] ERROR Failed passwords [$email] do not meet security criteria." >> /home/ash23/Downloads/soalsisop/users/auth.log 
    exit 1
fi

# Enkripsi password menggunakan base64
encrypted_password=$(echo -n "$password" | base64)

# Menambahkan data register ke dalam file users.txt
echo "$email:$username:$question:$answer:$encrypted_password:$unique" >> /home/ash23/Downloads/soalsisop/users/users.txt

# Menambahkan data register ke dalam file 
echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER SUCCESS] $unique [$email] registered successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log

echo "$unique registered successfully!"
