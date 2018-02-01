#!/bin/bash
# This script count the characters within a given hsk list {all,1,2,3,4,5,6} but not yet recorded. 
##############################################
# RUN: bash missing-audios.bash HSK2012_{all,1,2,3,4,5,6} # without .txt

if [[ ${1} == "--help" ]]
  then 
  	echo "usage: missing-audios.bash <input.txt>"
  	echo " " 
  	echo "missing-audios.bash -- compare the current list of audios to an input file's list of words, output the words in input file and not in audios."
  	echo " " 
  	echo "  <input>:    file.txt, itself should be a list of words, one by line, located in folder ./lists/." 
  	echo " " 
  	echo "Example usage: bash missing-audios.bash HSK2012"
  else
  	base=$(echo "$1" | sed 's/.txt//')
  	echo $base
	cd ./64k/hsk/
	ls -1 | sed -e 's/\(.mp3\|.ogg\|.flac\|^cmn-\)//g' | sort > ../../lists/audios_words_sorted.tmp.txt
	cd ../../
	sort ./lists/${1} > ./lists/${base}_sorted.tmp.txt
	comm  -23 ./lists/${base}_sorted.tmp.txt ./lists/audios_words_sorted.tmp.txt | sed '/HSK/d' | sort > ./lists/in_${base}_missing-audios.o.txt
	echo "In ${base} but not in audio-cmn: ${base}_not_audio-cmn_(HSK2000).txt"
	wc -l ./lists/in_${base}_missing-audios.o.txt
	cat ./lists/in_${base}_missing-audios.o.txt
fi

