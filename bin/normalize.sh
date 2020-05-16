#! /bin/bash
# Given installations of ffmpeg and ffmpeg-normalize, will normalize incoming wave files, keep a log of all 
# proceedings and output frequency-vs-time graphs for both input and output

echo "Input file [$1.wav] || date `date`" > "$1".ffmpeg.txt
ffmpeg -hide_banner -i "$1".wav >> "$1".ffmpeg.txt 2>&1

#ffmpeg -hide_banner -i "$1".wav -af lowpass=15000,highpass=200 "$1".tmp.wav >> "$1".ffmpeg.txt 2>&1
# loudness should be -23, per https://www.auphonic.com/blog/2013/01/07/loudness-targets-mobile-audio-podcasts-radio-tv/
# -f force overwrite
# -nt normalization scheme with -t level
# -p print stats
# --dual-mono obviously will sound different than actually one speaker
# -ar audio sample rate in Hz
# -e extra options for output, using this to set "audio channels" (ac) to 1 (e.g. mono)
ffmpeg-normalize -v -f -p --dual-mono -ar 96000 -nt ebu -t -19 -e '-ac 1' "$1".wav -o "$1".ffmpeg.wav >> "$1".ffmpeg.txt 2>&1
echo "Output file [$1.wav] || date `date`" >> "$1".ffmpeg.txt
ffmpeg -hide_banner -i "$1".ffmpeg.wav >> "$1".ffmpeg.txt  2>&1
ffmpeg -hide_banner -y -i "$1".ffmpeg.wav -lavfi showspectrumpic=s=960x540 "$1".ffmpeg.png
