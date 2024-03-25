#!/bin/bash

wget -O Sandbox.csv 'https://drive.google.com/uc?download=export&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'

echo "PRAKTIKUM SISOP || KELOMPOK 10"

echo -e "\nA) Menampilkan nama customer dengan sales paling tinggi"
awk -F ',' 'NR>1{if(max=="") { max=$17; cust=$6; } else if($17>max) { max=$17; cust=$6; }} END{print cust}' Sandbox.csv

echo -e "\nB) Menampilkan customer segment dengan profit paling kecil"
awk -F ',' 'NR>1{if(min=="") { min=$20; segment=$7; } else if($20<min) { min=$20; segment=$7; }} END{print segment}' Sandbox.csv 

echo -e "\nC) Menampilkan 3 kategori dengan total profit tertinggi"
awk -F ',' 'NR > 1 {profit[$14] += $20} END {for (category in profit) print category}' Sandbox.csv | sort -k2 -nr | head -n3

echo -e "\nD) Mengecek date order dan quantity dengan nama adriens/nama cust"
echo -e "Silahkan masukkan data customer"
echo -n "Nama Customer: " 
read nama_cust
awk -v nama="$nama_cust" -F ',' '$6==nama{  print "Order Date: "$2", Quantity: " $18}' Sandbox.csv
