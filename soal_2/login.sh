#!/bin/bash

# Mengecek email yang telah teregistrasi
cek_email() {
    if ! grep -q "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt; then
        echo "Email not registered!"
        exit 1
    fi
}

# Mengecek question yang telah teregistrasi
cek_question() {
    sav_ques=$(grep "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt | cut -d':' -f3)
    
    if [[ "$question" != "$sav_ques" ]]; then
        echo "Question not found!"
        exit 1
    fi
    
}

# Mengecek answer yang telah teregistrasi
cek_answer() {
    sav_ans=$(grep "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt | cut -d':' -f4)
    
    if [[ "$answer" != "$sav_ans" ]]; then
        echo "Answer not found!"
        exit 1
    fi
}

# Mengubah pass dari encrypt base64 
de_pass() {
    echo "$sav_pass" | base64 -d
}

# Mengecek pass apakah sesuai dgn yg sudah teregistrasi
validasi_login() {
    sav_pass=$(grep "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt | cut -d':' -f5)
    ded_pass=$(de_pass "$sav_pass")

    if [[ "$password" != "$ded_pass" ]]; then
        echo "Wrong password!"
        echo "$(date +"[%d/%m/%y %H:%M:%S]") [LOGIN FAILED] with email [$email] logged in failed." >> /home/ash23/Downloads/soalsisop/users/auth.log
        exit 1
    fi
}

# Mengecek pass apakah sesuai email, question, answer dgn yg sudah teregistrasi
validasi_forget() {
    sav_pass=$(grep "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt | cut -d':' -f5)
    ded_pass=$(de_pass "$sav_pass")
    echo "Your password is:" "$ded_pass"
}

cek_admin() {
    if [[ $email == *admin* ]]; then
        echo "Admin Menu"
        echo "1. Add User"
        echo "2. Edit User"
        echo "3. Delete User"
        echo "4. Logout"
        echo -n "jawab: "
        read jawaban

        case "$jawaban" in
          "1")
            nano /home/ash23/Downloads/soalsisop/users/users.txt     
            ;;
          "2")
            nano /home/ash23/Downloads/soalsisop/users/users.txt 
            ;;
          "3")
            nano /home/ash23/Downloads/soalsisop/users/users.txt 
            ;;
          "4")
            echo "logout"
            ;;
        esac
    else
        exit 1
    fi
}

echo "Welcome to Login System"
echo "1. Login"
echo "2. Forget Password"
echo -n "jawab: "
read jawaban

case "$jawaban" in
  "1")
    read -p "Enter your email: " email
    cek_email "$email"
    read -s -p "Password: " password
    echo

    validasi_login "$email" "$password"

    echo "Login successful"
    cek_admin "$email"

    echo "$(date +"[%d/%m/%y %H:%M:%S]") [LOGIN SUCCESS] with email [$email] logged in successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log
     
    ;;
  "2")
    echo "Forget password?"
    echo "Enter your email:"
    read email
    cek_email "$email"
    read -p "Security Question: " question
    cek_question "$question"
    read -p "Enter your answer: " answer
    cek_answer "$answer"

    validasi_forget "$email"

    ;; 
    *)
    echo "!! ERROR !!"
    ;;
esac

