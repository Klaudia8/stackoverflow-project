#! /usr/bin/bash
#echo -e 'Put url to extract datasets: \c'
#read url
url='https://archive.org/download/stackexchange/' # website url
path='/home/ubuntu/data/' # path to data directory
filename="${path}test.txt" # file with datasets names
n=1
while read line; do
	# read each line
	zip_dir="/home/ubuntu/data/${line}"
	full_url="${url}${line}"
	echo "Extracting line $n : $full_url"
	wget -O $zip_dir $full_url
	new_dir=${zip_dir::-21}
	7z x $zip_dir -o$new_dir
	s3_dir=${line::-21}
	ls $new_dir | grep -E "(Comments|Posts|Users).xml" > temporary_file.txt
	while read file; do
		aws s3 mv "$new_dir/${file}" "s3://stackexchangedataxml/${s3_dir}/${file}" 
	done < temporary_file.txt
	aws s3 mv "$new_dir" "s3://stackexchangedataxml/${s3_dir}" --recursive 
	# aws s3 cp --recursive "$new_dir" "s3://stackexchangedata/${s3_dir}" 
	n=$((n+1))
done < $filename

