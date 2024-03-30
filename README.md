# Sisop-1-2024-MH-IT14
Laporan pengerjaan soal shift modul 1 Praktikum Sistem Operasi 2024 olehh Kelompok IT14
## Praktikan Sistem Operasi Kelompok IT14
1. Tsaldia Hukma Cita          : 5027231036
2. Muhammad Faqih Husain       : 5027231023
3. Muhammad Syahmi Ash Shidqi  : 5027231085

## Soal 1
### Study Case
1. Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan. Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe. 
- Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi
- Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil
-  Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi
-  Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens
### Solution
Pertama untuk mendownload file 'Sandbox.csv' di dalam google drive dari link yang tersedia maka menggunakan perintah wget, sedangkan untuk menentukan file mana yang akan didownload dapat menggunakan perintah -O
```
wget -O Sandbox.csv 'https://drive.google.com/uc?download=export&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
```
Selanjutnya untuk mengecek apakah file 'Sandbox.csv' telah berhasil didownload dapat menggunakan perintah ls -l 'namafile' yang akan memunculkan besaran memori dari file tersebut
```
ls -l Sandbox.csv
```
Terakhir untuk memunculkan isi dari file 'Sandbox.csv' dapat menggunakan perintah cat 'namafile'
```
cat Sandbox.csv
```
Setelah file 'Sandbox.csv' telah berhasil terdownload maka kita akan membuat sebuah file 'sandbox.sh' dengan perintah nano 'namafile'
```
nano sandbox.sh
```

#### Bagian A
Untuk dapat memunculkan customer dengan sales paling tinggi maka dapat menggunakan perintah berikut:
```
awk -F ',' 'NR>1{if(max=="") { max=$17; cust=$6; } else if($17>max) { max=$17; cust=$6; }} END{print cust}' Sandbox.csv
```
Penjelasan
- awk -F ',' --> untuk membaca baris lalu memisah tiap bagian di baris yang dipisah dgn ','
-  NR>1 --> untuk memproses tiap baris setelah header
- if(max=="") { max=$17; cust=$6; } --> fungsi untuk mengisiasi nilai max adalah baris pertama di kolom 17, dan cust adalah baris pertama di kolom 6
- else if($17>max) { max=$17; cust=$6; } --> fungsi untuk mengganti nilai max dan nilai cust ketika program menemukan nilai max(sales) yang lebih tinggi dari baris-baris sebelumnya dibanding baris saat ini
- END{print cust}' --> ketika semua sudah diproses maka outputnya adalah nama cust dengan sales terbesar
- Sandbox.csv --> nama file 

#### Bagian B
Untuk memunculkan customer segment dengan profit paling kecil, maka dapat menggunakan perintah berikut:
```
awk -F ',' 'NR>1{if(min=="") { min=$20; segment=$7; } else if($20<min) { min=$20; segment=$7; }} END{print segment}' Sandbox.csv 
```
Penjelasan
- awk -F ',' --> untuk membaca baris lalu memisah tiap bagian di baris yang dipisah dgn ','
-  NR>1 --> untuk memproses tiap baris setelah header
- if(min=="") { min=$20; segment=$7; } --> fungsi untuk mengisiasi nilai min adalah baris pertama di kolom 20, dan nilai segment adalah baris pertama di kolom 7
-  else if($20<min) { min=$20; segment=$7; } --> fungsi untuk mengganti nilai min dan segment ketika program menemukan nilai min(profit) yang lebih kecil dari baris-baris sebelumnaya dibanding baris saat ini
- END{print segment}' --> ketika semua sudah diproses maka outputnya adalah nama segment dengan profit paling kecil
- Sandbox.csv --> nama file 

#### Bagian C
Untuk memuncul 3 kategori dengan total profit tertinggi, maka dapat menggunakan perintah berikut
```
awk -F ',' 'NR > 1 {profit[$14] += $20} END {for (category in profit) print category}' Sandbox.csv | sort -k2 -nr | head -n3
```
Penjelasan
- awk -F ',' --> untuk membaca baris lalu memisah tiap bagian di baris yang dipisah dgn ','
-  NR>1 --> untuk memproses tiap baris setelah header
-  {profit[$14] += $20} --> untuk menjumlahkan nilai profit untuk tiap jenis kategori dalam bentuk array
-  END {for (category in profit) print category} --> setelah program selesai dijalankan maka outputnya akan memunculkan semua kategori yang ada di dalam array profit
-  Sandbox.csv --> nama file 
-  | sort -k2 -nr --> untuk mengurutkan nilai profit dari output yang didapat dengan urutan dari yang paling besar hingga terkecil
-  | head -n3 --> output yang telah diurutkan akan dibatasi hingga menjadi 3 baris teratas saja

#### Bagian D
Untuk memunculkan purchase date dan quantity dari customer dengan nama 'Adriaens Grayland' 
```
echo -n "Nama Customer: "; read nama_cust; awk -v nama="$nama_cust" -F ',' '$6==nama{  print "Order Date: "$2", Quantity: " $18}' Sandbox.csv 
```
Penjalasan 
- echo -n "Nama Customer: "; --> untuk output "Nama Customer", dan dapat menerima input di baris yang sama 
- read nama_cust; --> untuk membaca inputan
- awk -v nama="$nama_cust" --> untuk membuat variabel nama dan memasukkan nilai dari Nama_cust
- '$6==nama{  print "Order Date: "$2", Quantity: " $18}' --> untuk mencocokkan baris dengan kolom. Saat input "Adriaens Grayland" maka program akan mencari di setiap baris di kolom Customer Name(6) yang sesuai dengan input, dan mengeluarkan output berupa nilai kolom Order Date(2) dan Quantity(18)
-  Sandbox.csv --> nama file  

##### sandbox.sh
```
#!/bin/bash

wget -O Sandbox.csv 'https://drive.google.com/uc?download=export&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'

echo "PRAKTIKUM SISOP || KELOMPOK 14"

echo -e "\nA) Menampilkan nama customer dengan sales paling tinggi"
awk -F ',' 'NR>1{if(max=="") { max=$17; cust=$6; } else if($17>max) { max=$17; cust=$6; }} END{print cust}' Sandbox.csv

echo -e "\nB) Menampilkan customer segment dengan profit paling kecil"
awk -F ',' 'NR>1{if(min=="") { min=$20; segment=$7; } else if($20<min) { min=$20; segment=$7; }} END{print segment}' Sandbox.csv 

echo -e "\nC) Menampilkan 3 kategori dengan total profit tertinggi"
awk -F ',' 'NR > 1 {profit[$14] += $20} END {for (category in profit) print category}' Sandbox.csv | sort -k2 -nr | head -n3

#kode di bawah ini bisa menyelesaikan soal bagian D jika input yg dimasukkan adalah 'Adriaens Grayland'
echo -e "\nD) Menampilkan date order dan quantity dati nama customer"
echo -e "Silahkan masukkan data customer"
echo -n "Nama Customer: " 
read nama_cust
awk -v nama="$nama_cust" -F ',' '$6==nama{  print "Order Date: "$2", Quantity: " $18}' Sandbox.csv
```
#### Hasil Pengerjaan
![Screenshot (511)](https://github.com/fqhhusain/Sisop-1-2024-MH-IT14/assets/150339585/8cb2f9d1-7f9a-41fe-9123-cefd5df3ca50)

### Kendala/Eror
Tidak ada kendala selama pengerjaan

### Revision
Terdapat revisi dari aslab penguji, yaitu untuk mengubah bagian D agar tidak perlu input nama customer dan dapat langsung memunculkan jawabannya, yaitu data order date dan quantity dari customer dengan nama "Adriaens Grayland"

#### Bagian D
```
grep -i "Adriaens .*" Sandbox.csv| awk -F ',' '{print "Customer: "$6 " || Order Date: "$2 " ||  Quantity: "$18 }'
```
Penjelasan 
-  grep -i "Adriaens .*" Sandbox.csv --> mencari string 'Adriaens' di dalam file 'Sandbox.csv' tanpa memperhatikan besar kecil huruf
-  awk -F ',' --> untuk membaca baris lalu memisah tiap bagian di baris yang dipisah dgn ','
-  {print "Customer: "$6 " || Order Date: "$2 " ||  Quantity: "$18 } --> setelah menemukan data tiap kolom dari customer "Adriaens", maka perintah ini akan mengeluarkan output berupa nama customer(6), order date(2), dan quantity(18) sesuai dengan letak kolom data

##### sandbox.sh
```
#!/bin/bash

wget -O Sandbox.csv 'https://drive.google.com/uc?download=export&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'

echo "PRAKTIKUM SISOP || KELOMPOK 14"

echo -e "\nA) Menampilkan nama customer dengan sales paling tinggi"
awk -F ',' 'NR>1{if(max=="") { max=$17; cust=$6; } else if($17>max) { max=$17; cust=$6; }} END{print cust}' Sandbox.csv

echo -e "\nB) Menampilkan customer segment dengan profit paling kecil"
awk -F ',' 'NR>1{if(min=="") { min=$20; segment=$7; } else if($20<min) { min=$20; segment=$7; }} END{print segment}' Sandbox.csv 

echo -e "\nC) Menampilkan 3 kategori dengan total profit tertinggi"
awk -F ',' 'NR > 1 {profit[$14] += $20} END {for (category in profit) print category}' Sandbox.csv | sort -k2 -nr | head -n3

echo -e "\nD) Mengecek date order dan quantity dengan nama customer Adriaens"
grep -i "Adriaens .*" Sandbox.csv| awk -F ',' '{print "Customer: "$6 " || Order Date: "$2 " ||  Quantity: "$18 }'

#kode revisi di atas kurang lebih sama, hanya saja kode di atas dapat secara langsung memunculkan data cust tanpa harus input nama cust
```

#### Hasil Revisi
![Screenshot (512)](https://github.com/fqhhusain/Sisop-1-2024-MH-IT14/assets/150339585/2231154f-114d-400b-8f1f-b0f868fce5bf)


## Soal 2
### Study Case
2. Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya 
### Solution
# Register
a. Langkah awal Oppie membuat script bernama register.sh, `nano register.sh` untuk program register dan login.sh `nano login.sh` dalam sebuah folder yang sama. 

b. Dalam program register admin/user diminta untuk membuat email, username, pertanyaan keamanan dan jawaban, dan password
```
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
```
Terdapat fungsi `cek_email` yang akan mengecek apakah email sudah terdaftar atau belum bila sudah terdaftar maka akan keluar output
bahwa "Email $email already registered. Please choose another one!" dan akan tercatat dalam file auth.log bahwa [REGISTER FILED].

c.  Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin. Untuk itu kita membutuhkan sebuah code untuk mengecek apakah email mengandung kata admin.
```
# Cek apakah email mengandung kata admin
if [[ $email == *admin* ]]; then
    unique="admin"
else
    unique="user"
fi
```
d. Dalam program register user/admin diminta untuk membuat password dengan kriteria :
   - Password tersebut harus di encrypt menggunakan base64
   - Password yang dibuat harus lebih dari 8 karakter
   - Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
   - Harus terdapat paling sedikit 1 angka

untuk itu kita membutuhkan sebuah code untuk validasi password
```
# Validasi password
if [[ ${#password} -lt 8 || ! "$password" =~ [[:lower:]] || ! "$password" =~ [[:upper:]] || ! "$password" =~ [[:digit:]] || ! "$password" =~ [[:punct:]] ]]; then
    echo "passwords do not meet security criteria!"
    echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER FAILED] ERROR Failed passwords [$email] do not meet security criteria." >> /home/ash23/Downloads/soalsisop/users/auth.log 
    exit 1
fi

# Enkripsi password menggunakan base64
encrypted_password=$(echo -n "$password" | base64)
```
apabila password tidak sesuai kriteria maka akan keluar output "passwords do not meet security criteria!" dan terdata dalam file auth.log bahwa [REGISTER FAILED] karena password tidak memenuhi kriteria dan apabila password memnuhi kriteria maka password akan terenkripsi ke base64.

e. Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users lalu membuat file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.

membuat folder users `mkdir users` lalu masuk ke dalam folder tersebut `cd users` dan membuat script users.txt `nano users.txt`dan kita membutuhkan code dalam register.sh untuk mencatat data register ke dalam file users.txt
```
# Menambahkan data register ke dalam file users.txt
echo "$email:$username:$question:$answer:$encrypted_password:$unique" >> /home/ash23/Downloads/soalsisop/users/users.txt
```
`/home/ash23/Downloads/soalsisop/users/users.txt` adalah alamat dari file users.txt

# Login
mengedit file login.sh `nano login.sh`
```
# main
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
    echo "$(date +"[%d/%m/%y %H:%M:%S]") [LOGIN SUCCESS] with email [$email] logged in successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log
    cek_admin "$email"
    ;;
  "2")
    echo "Forget password?"
    echo "Enter your email:"
    read email
    cek_email "$email"
    read -p  "Security Question: " question
    cek_question "$question"
    read -p "Enter your answer: " answer
    cek_answer "$answer" 
    validasi_forget "$email"
    ;; 
    *)
    echo "!! ERROR !!"
    ;;
esac

```
`# main` adalah tampilan untuk menu login.

f. Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.

untuk melakukan login kita harus "jawab: 1"
pada case 1 terdapat 
- fungsi `cek_email` 
```
#!/bin/bash
# Mengecek email yang telah teregistrasi
cek_email() {
    if ! grep -q "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt; then
        echo "Email not registered!"
        exit 1
    fi
}
```
berfungsi untuk mengecek apakah email sudah teregistrasi/terdata di dalam file users.txt, apabila email belum teregistrasi maka akan keluar output "Email not registered!". 

- fungsi `validasi login`
```
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
```
Berfungsi untuk mengecek apakah password dengan email yang diinputkan sudah sesui atau belum, apabila tidak sesuai maka akan keluar output "Wrong password!" dan akan terdata [LOGIN FAILED] pada file auth.log.


g. Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password

untuk melakukan forget password kita harus "jawab: 2"
pada case 2 terdapat 
- fungsi `cek_email` 
```
#!/bin/bash
# Mengecek email yang telah teregistrasi
cek_email() {
    if ! grep -q "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt; then
        echo "Email not registered!"
        exit 1
    fi
}
```
berfungsi untuk mengecek apakah email sudah teregistrasi/terdata di dalam file users.txt, apabila email belum teregistrasi maka akan keluar output "Email not registered!". 

- fungsi `cek_question`
```
# Mengecek question yang telah teregistrasi
cek_question() {
    sav_ques=$(grep "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt | cut -d':' -f3)
    
    if [[ "$question" != "$sav_ques" ]]; then
        echo "Question not found!"
        exit 1
    fi
}
```
berfungsi untuk mengecek apakah question dengan email yang diinputkan sesuai, apabila tidak sesuai maka akan keluar output "Question not found!"

- fungsi `cek_answer`
```
# Mengecek answer yang telah teregistrasi
cek_answer() {
    sav_ans=$(grep "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt | cut -d':' -f4) 
    
    if [[ "$answer" != "$sav_ans" ]]; then
        echo "Answer not found!"
        exit 1
    fi
}
```
berfungsi untuk mengecek apakah answer dengan email yang diinputkan sesuai, apabila tidak sesuai maka akan keluar output "Answer not found!"

- fungsi `validasi_forget`
```
# Mengeluarkan password yang terlupakan
validasi_forget() {
    sav_pass=$(grep "^$email:" /home/ash23/Downloads/soalsisop/users/users.txt | cut -d':' -f5)
    ded_pass=$(de_pass "$sav_pass")
    echo "Your password is:" "$ded_pass"
}
```
berfungsi untuk mengeluarkan password yang tersimpan di dalam file users.txt

h. Setelah user melakukan login akan keluar pesan sukses, 
```
    echo "Login successful"
    echo "$(date +"[%d/%m/%y %H:%M:%S]") [LOGIN SUCCESS] with email 
    [$email] logged in successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log
    cek_admin "$email"
```
namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin.

apabila seorang admin melakukan login maka akan masuk ke fungsi `cek_admin`
```
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
                    # Meminta data user tambahan
                    echo "Add User"
                    read -p "Enter email: " email
                    cek_e "$email"
            	    read -p "Enter username: " username
                    read -p "Enter a security question: " question
                    read -p "Enter the answer to security question: " answer
                    read -s -p "Enter a password (minimum 8 Characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same username, birthdate, or name): " password
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
                        exit 1
                    fi

                    # Enkripsi password menggunakan base64
                    encrypted_pass=$(echo -n "$password" | base64)

                    # Menambahkan pengguna baru ke dalam file users.txt
                    echo "$email:$username:$question:$answer:$encrypted_pass:$unique" >> /home/ash23/Downloads/soalsisop/users/users.txt
                    echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER SUCCESS] Admin add [$email] registered successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log
                    echo "Add User Successfully!"
                    ;;
                "2")
                    # menampilkan email yang ada di users.txt
                    echo "Data users"
                    cut -d':' -f1 /home/ash23/Downloads/soalsisop/users/users.txt 
 
                    # mengedit user
                    echo "Edit User"
                    echo "Enter email: "
                    read email 
                    read -p "Enter new username: " new_user
                    read -p "Enter a new security question: " new_secques
                    read -s -p "Enter a new password (minimum 8 Characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same username, birthdate, or name):" new_pass
                    echo

                    # Cek apakah email mengandung kata admin
                    if [[ $email == *admin* ]]; then
                        unique="admin"
                    else
                        unique="user"
                    fi

                    # Validasi password
                    if [[ ${#new_pass} -lt 8 || ! "$new_pass" =~ [[:lower:]] || ! "$new_pass" =~ [[:upper:]] || ! "$new_pass" =~ [[:digit:]] || ! "$new_pass" =~ [[:punct:]] ]]; then
                        echo "Edit failed, passwords do not meet security criteria!"
                        exit 1 
                    fi

                    # Enkripsi password menggunakan base64
                    encrypted_new_pass=$(echo -n "$new_pass" | base64)

                    sed -i "s/^$email:.*/$email:$new_user:$new_secques:$new_secans:$encrypted_new_pass:$unique/" /home/ash23/Downloads/soalsisop/users/users.txt 
                    echo "User $email succesfully edited" 
                    ;;
                "3")
                    # menampilkan email yang ada di users.txt
                    echo "Data users"
                    cut -d':' -f1 /home/ash23/Downloads/soalsisop/users/users.txt 

                    # menghapus user
                    echo "Delete User"
                    read -p "Enter email: " email
                    sed -i "/^$email:/d" /home/ash23/Downloads/soalsisop/users/users.txt
                    echo "User $email succesfully deleted"  
                    ;;
                "4")
                    echo "logout"
                    ;;
            esac
    fi
}
``` 
i. Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit
```
 # menampilkan email yang ada di users.txt
                    echo "Data users"
                    cut -d':' -f1 /home/ash23/Downloads/soalsisop/users/users.txt
```
j. Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.
   - Format: [date] [type] [message]
   - Type :
REGISTER SUCCESS
```
echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER SUCCESS] $unique [$email] registered successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log

#untuk admin add user
echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER SUCCESS] Admin add [$email] registered successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log

```
REGISTER FAILED
untuk email sudah terdaftar
```
 echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER FAILED] ERROR Failed register email [$email] already registered." >> /home/ash23/Downloads/soalsisop/users/auth.log 

```
untuk password tidak sesuai kriteria
```
echo "$(date +"[%d/%m/%y %H:%M:%S]") [REGISTER FAILED] ERROR Failed passwords [$email] do not meet security criteria." >> /home/ash23/Downloads/soalsisop/users/auth.log
```
LOGIN SUCCESS
```
echo "$(date +"[%d/%m/%y %H:%M:%S]") [LOGIN SUCCESS] with email [$email] logged in successfully." >> /home/ash23/Downloads/soalsisop/users/auth.log
```

LOGIN FAILED
```
echo "$(date +"[%d/%m/%y %H:%M:%S]") [LOGIN FAILED] with email [$email] logged in failed." >> /home/ash23/Downloads/soalsisop/users/auth.log

```
### Revision
terdapat revisi untuk admin dapat add user, edit user, dan delete user yang sebelumnya langsung masuk ke dalam file users.txt `nano users.txt`
## Soal 3
### Study Case
3. Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

### Solution
a. Alyss membuat script bernama awal.sh, `nano awal.sh` untuk download file yang diberikan oleh Yanuar 
```
#!/bin/bash
wget -O genshin.zip 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN' 
```
dan unzip terhadap file yang telah diunduh 
```
unzip genshin.zip 
unzip genshin_character.zip
```
dan decode setiap nama file yang terenkripsi dengan hex .
```
for encrypted_file in  genshin_character/*
  do
    filename=$(basename -- "$encrypted_file")
    filename="${filename%.*}"
    decoded_filename=$(echo "$filename" | xxd -r -p)
    mv "$encrypted_file" "genshin_character/$decoded_filename"
  done
```
Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter
   - Format: Region - Nama - Elemen - Senjata.jpg
```
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
```
b. Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada
   - Format: [Nama Senjata] : [jumlah]
```
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
```
c. Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip
```
rm genshin_character.zip 
rm list_character.csv 
rm genshin.zip
```
Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh `touch search.sh` untuk melakukan pengecekan terhadap setiap file tiap 1 detik.Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.

d. Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar
    - Format: [date] [type] [image_path]
    - Ex: 
      [24/03/20 17:18:19] [NOT FOUND] [image_path]
      [24/03/20 17:18:20] [FOUND] [image_path]

Program keseluruhan dari search.sh
```
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
```
Penjelasan

```
#!/bin/bash

log_file="image.log"
decryption_file="decrypted.txt"
link_file="link.txt"
secret_image_file="secret_image.jpg"

current_datetime=$(date +"%d/%m/%y %H:%M:%S")
```
menyimpan waktu saat ini untuk melakukan pencatatan log
```
for file in genshin_character/*/*.jpg
do
  steghide extract -sf "$file" -xf encrypt.txt -p ""
```
Meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide.
```
  decrypt=$(cat encrypt.txt | base64 -d 2>/dev/null)
  echo "$decrypt" > "$decryption_file"
```
dekripsi dengan hex pada tiap file txt untuk mendapatkan sebuah url.
```
  if [[ "$decrypt" == *"http"* ]]
```
Melakukan pengecekan url dengan mencari sub string http
```
  then
    echo "$decrypt" > "$link_file"

    wget -O "$secret_image_file" "$decrypt"
```
mendownload secret image yang telah ditemukan
```
    echo "[$current_datetime] [FOUND] [$file]" >> "$log_file"
```
Melakukan pencatatan log pada file image.log 
```
    echo -e "\nSecret image downloaded from $decrypt and saved as $secret_image_file"
    break
  else
    echo "[$current_datetime] [NOT FOUND] [$file]" >> "$log_file"
```
Melakukan pencatatan log pada file image.log 
```
  fi

  rm encrypt.txt
  if [ -f "$decryption_file" ]; then
    rm "$decryption_file"
  fi

  sleep 1
```
Menunggu 1 detik untuk melakukan pengecekan selanjutnya
```
done
rm decrypted.txt
rm encrypt.txt
```
Menghapus file yang tidak diperlukan
### Hasil Akhir
1. search.sh
2. awal.sh
3. image.log
4. genshin_character
![genshin char](https://github.com/fqhhusain/Sisop-1-2024-MH-IT14/assets/88548292/380e5b26-efaf-4ab2-ada6-eddba88b64ec)
![Screenshot (30)](https://github.com/fqhhusain/Sisop-1-2024-MH-IT14/assets/88548292/16345a68-fe58-4167-ba16-87250d54724e)
6. [filename].txt
7. [image].jpg

### Revision
1. Tidak ada, pada saat demo sudah lancar dan tidak ada tambahan dari aslab penguji
## Soal 4
### Study Case
Stitch sangat senang dengan PC di rumahnya. Suatu hari, PC nya secara tiba-tiba nge-freeze 🤯 Tentu saja, Stitch adalah seorang streamer yang harus setiap hari harus bermain game dan streaming.  Akhirnya, dia membawa PC nya ke tukang servis untuk diperbaiki. Setelah selesai diperbaiki, ternyata biaya perbaikan sangat mahal sehingga dia harus menggunakan uang hasil tabungan nya untuk membayarnya. Menurut tukang servis, masalahnya adalah pada CPU dan GPU yang overload karena gaming dan streaming sehingga mengakibatkan freeze pada PC nya. Agar masalah ini tidak terulang kembali, Stitch meminta kamu untuk membuat sebuah program monitoring resource yang tersedia pada komputer.

Buatlah program monitoring resource pada PC kalian. Cukup monitoring ram dan monitoring size suatu directory. Untuk ram gunakan command `free -m`. Untuk disk gunakan command `du -sh <target_path>`. Catat semua metrics yang didapatkan dari hasil `free -m`. Untuk hasil `du -sh <target_path>` catat size dari path directory tersebut. Untuk target_path yang akan dimonitor adalah /home/{user}/. 

1. Masukkan semua metrics ke dalam suatu file log bernama metrics_{YmdHms}.log. {YmdHms} adalah waktu disaat file script bash kalian dijalankan. Misal dijalankan pada 2024-03-20 15:00:00, maka file log yang akan tergenerate adalah metrics_20240320150000.log. 

2. Script untuk mencatat metrics diatas diharapkan dapat berjalan otomatis pada setiap menit. 

3. Kemudian, buat satu script untuk membuat agregasi file log ke satuan jam. Script agregasi akan memiliki info dari file-file yang tergenerate tiap menit. Dalam hasil file agregasi tersebut, terdapat nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. File agregasi akan ditrigger untuk dijalankan setiap jam secara otomatis. Berikut contoh nama file hasil agregasi metrics_agg_2024032015.log dengan format metrics_agg_{YmdH}.log 

4. Karena file log bersifat sensitif pastikan semua file log hanya dapat dibaca oleh user pemilik file. 

Note:
- Nama file untuk script per menit adalah minute_log.sh
- Nama file untuk script agregasi per jam adalah aggregate_minutes_to_hourly_log.shN
- Semua file log terletak di /home/{user}/log
- Semua konfigurasi cron dapat ditaruh di file skrip .sh nya masing-masing dalam bentuk comment


Berikut adalah contoh isi dari file metrics yang dijalankan tiap menit:
mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size 15949,10067,308,588,5573,4974,2047,43,2004,/home/user/coba/,74M

Berikut adalah contoh isi dari file aggregasi yang dijalankan tiap jam:
type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size minimum,15949,10067,223,588,5339,4626,2047,43,1995,/home/user/coba/,50M maximum,15949,10387,308,622,5573,4974,2047,52,2004,/home/user/coba/,74M average,15949,10227,265.5,605,5456,4800,2047,47.5,1999.5,/home/user/coba/,62M

### Solution 
### Revision
1. Mengubah format isi dari file metrics yang dijalankan tiap menit
![Screenshot (33)](https://github.com/fqhhusain/Sisop-1-2024-MH-IT14/assets/88548292/b989d737-63c6-4054-955f-183039e3748d)
Menjadi
![Screenshot (32)](https://github.com/fqhhusain/Sisop-1-2024-MH-IT14/assets/88548292/e3a0edfb-1b15-4213-ada8-8c45c9413574)
2. Mengubah format isi dari file aggregasi yang dijalankan tiap jam
![Screenshot (34)](https://github.com/fqhhusain/Sisop-1-2024-MH-IT14/assets/88548292/eba9c68d-5f0f-4d4a-b3b0-51fba117e32b)
Menjadi
