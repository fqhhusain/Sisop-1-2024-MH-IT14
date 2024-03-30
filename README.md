# Sisop-1-2024-MH-IT14
Laporan pengerjaan soal shift modul 1 Praktikum Sistem Operasi 2024 olehh Kelompok IT14
## Praktikan Sistem Operasi Kelompok IT14
1. Tsaldia Hukma Cita          : 5027231036
2. Muhammad Faqih Husain       : 5027231023
3. Muhammad Syahmi Ash Shidqi  : 5027231085

## Soal 1
### Study Case
1. Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan. Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe. a. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi
b. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil
c. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 
d. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens
### Solution
### Revision

## Soal 2
### Study Case
2. Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya 
a. Buatlah 2 program yaitu login.sh dan register.sh
b. Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password
c. Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin 
d. Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi
   - Password tersebut harus di encrypt menggunakan base64
   - Password yang dibuat harus lebih dari 8 karakter
   - Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
   - Harus terdapat paling sedikit 1 angka 
e. Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.
f. Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.
g. Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password
h. Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin.
i. Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit
j. Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.
   - Format: [date] [type] [message]
   - Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED
     Ex:
     [23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully
     [23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]
### Solution
### Revision
## Soal 3
### Study Case
3. Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.


b. Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada
   - Format: [Nama Senjata] : [jumlah]
	 
c. Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip
Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh untuk melakukan pengecekan terhadap setiap file tiap 1 detik. Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.

d. Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar
    - Format: [date] [type] [image_path]
    - Ex: 
      [24/03/20 17:18:19] [NOT FOUND] [image_path]
      [24/03/20 17:18:20] [FOUND] [image_path]
### Solution
a. Alyss membuat script bernama awal.sh, `nano awal.sh` untuk download file yang diberikan oleh Yanuar `wget -O genshin.zip 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN' ` dan unzip terhadap file yang telah diunduh 
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
```
#!/bin/bash
```
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

rm genshin_character.zip 
rm list_character.csv 
rm genshin.zip
```
search.sh
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
### Hasil Akhir
1. search.sh
2. awal.sh
3. image.log
4. genshin_character
5. [filename].txt
6. [image].jpg

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
