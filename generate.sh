#!/bin/bash
CC="gcc"
FLAGS="-Wall -O0"
OFILE="main.o"
SFILE="main.s"
OUTFILE="main.out"
COUNTER=20

# Clean up previous intermediate files
rm -f $OFILE $SFILE $OUTFILE

echo "Making code to attempt to overload branch table buffer"
# Start off the file with preamble.s. A single '>' overwrites contents.
cat preamble.s > $SFILE

# This is the code to insert arbitrary instructions into main.s. 
until [ $COUNTER -lt 1 ]; do
    printf "\tmulsd \%xmm0, \%xmm1\n" >> $SFILE
    let COUNTER-=1
done

# Append footer.s to the file to make it complete. Double '>>' appends, rather
# than overwrites, the contents in a file.
cat footer.s >> $SFILE

# Attempt to compile the code
# First, generate the .o file
$CC $FLAGS -o $OFILE -c $SFILE
# Second, link and generate executable
$CC $FLAGS -o $OUTFILE $OFILE
