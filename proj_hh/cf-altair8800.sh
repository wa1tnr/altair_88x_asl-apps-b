#!/bin/sh

help() {
cat << __EOF

  binaries:

    /usr/bin/picocom
    /usr/bin/ascii-xfr

  packages:

    /var/lib/dpkg/info/picocom.list:/usr/bin/picocom
    /var/lib/dpkg/info/minicom.list:/usr/bin/ascii-xfr
__EOF
}

if [ $# -lt 1 ]; then
    echo "Not enough arguments"
    echo "Use:  ./picot.sh /dev/ttyACM0"
    exit 1
fi

if [ $1 = "-help" ] || [ $1 = "--help" ]; then
    help
    exit 0
fi

echo "NON-STANDARD escape char is the backslash, not the usual Control+A"
echo "Control \, Control Q to quit"
echo "Control \, Control S to send a file from the local directory"
# used to be may 2020: picocom -f n -p n -d 8 -b 115200 --omap delbs --send-cmd "ascii-xfr -sn -l 150 -c 25" ${1}
# for escape of control backslash: -e \\
echo "Good for 9term August 2020"
# picocom -e \\ -f n -p n -d 8 -b 115200 --omap delbs,lfcr --send-cmd "ascii-xfr -s -l 1850 -c 10" ${1}
# picocom -e \\ -f n -p n -d 8 -b 115200 --omap delbs,lfcr --send-cmd "ascii-xfr -s -l 1850 -c 10" ${1}
# recentmost: picocom -e \\ -f n -p n -d 8 -b 115200 --omap delbs,lfcr --send-cmd "ascii-xfr -s -l 1850 -c 10" ${1}

# WORKS FEB 11 2021:
# picocom -e \\ -f n -p n -d 8 -b 115200 --omap delbs --send-cmd "ascii-xfr -sn -l 150 -c 25" ${1}

# Now let us have a control J thing happening:

# just before 5 Jun 2022:
# picocom -e \\ -f n -p n -d 8 -b 115200 --omap delbs,crlf --send-cmd "ascii-xfr -sn -l 5 -c 1" ${1}

# Altair BASIC didn't respond to pressing ENTER 05 June 2022

# BASIC at least responds now (05 Jun 2022, 16:53z):
# picocom -e \\ -f n -p n -d 8 -b 115200 --omap delbs,crcrlf --send-cmd "ascii-xfr -sn -l 5 -c 1" ${1}

# however, a 'M'emory dump gets two line endings and prematurely aborts.
picocom -e \\ -f n -p n -d 8 -b 115200 --omap delbs,lfcr --send-cmd "ascii-xfr -sn -l 5 -c 1" ${1}

exit 0

cat << __EOF
<map> is a comma-separated list of one or more of:
  crlf : map CR --> LF
  crcrlf : map CR --> CR + LF
  igncr : ignore CR
  lfcr : map LF --> CR
  lfcrlf : map LF --> CR + LF
  ignlf : ignore LF
  bsdel : map BS --> DEL
  delbs : map DEL --> BS
  spchex : map special chars (excl. CR, LF & TAB) --> hex
  tabhex : map TAB --> hex
  crhex : map CR --> hex
  lfhex : map LF --> hex
  8bithex : map 8-bit chars --> hex
  nrmhex : map normal ascii chars --> hex
<?> indicates the equivalent short option.
Short options are prefixed by "-" instead of by "--".

__EOF

# end
