# Process raw audio files into denoised, mp3, human-friendly filenames.
# Input: cmn-Xiao Chen-zhe4-LL12064.wav
# Ouput: cmn-zhe4.mp3 (denoised)

# Denoise
mkdir -p ./clean;
for file in ./cmn-*.wav;do key=$(basename "$file" .wav); sox "$file" ./clean/"$key".wav noisered ./noise.prof 0.21; done;

# Convert to mp3
mkdir -p ./mp3;
for file in ./clean/*.wav;do   key=$(basename "$file" .wav).mp3;   lame --cbr -b 64 -m m -h --resample 22.05 "$file" "./mp3/$key"; done;

# Rename
mkdir -p ./mp3-final;
for file in ./mp3/*.wav;do key=$(basename "$file" | cut -d- -f3); cp "$file" ./mp3-final/cmn-"$key".wav; done
