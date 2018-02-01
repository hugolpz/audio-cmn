# Require external ./flac/ folder. See README.md.

############################################################################
## FOLDERS
mkdir -p ./18k-abr ./18k-abr/hsk ./18k-abr/syllabs
mkdir -p ./24k-abr ./24k-abr/hsk ./24k-abr/syllabs
mkdir -p ./64k     ./64k/hsk     ./64k/syllabs
mkdir -p ./96k     ./96k/hsk     ./96k/syllabs

############################################################################
## HSK : From 5596 hsk .flac to 5596 well-named .mp3 at 96k,64k cbr and 24k,18k abr.
for file in ./flac/*.flac
do
  key=$(avconv -i "$file" 2>&1 | sed -ne 's/.*SWAC_TEXT *: //p')
  lame --abr 18    -m m -h --resample 22.05 "$file" "./18k-abr/hsk/cmn-$key.mp3"
  lame --abr 24    -m m -h --resample 22.05 "$file" "./24k-abr/hsk/cmn-$key.mp3"
  lame --cbr -b 64 -m m -h --resample 22.05 "$file" "./64k/hsk/cmn-$key.mp3"
  lame --cbr -b 96 -m m -h --resample 22.05 "$file" "./96k/hsk/cmn-$key.mp3"
done

############################################################################
## SYLLABS : From 1707 syllabs .mp3 (64k) to 1707 well-named .mp3 at 64k cbr and 24k,18k abr.
for file in ./64k/syllabs/*.mp3
do
  key=$(basename "$file" .mp3).mp3              # name of the file minus .mp3, plus .mp3 
  lame --abr 12    -m m -h --resample 22.05 "$file" "./18k-abr/syllabs/$key"
  lame --abr 24    -m m -h --resample 22.05 "$file" "./24k-abr/syllabs/$key"
done

