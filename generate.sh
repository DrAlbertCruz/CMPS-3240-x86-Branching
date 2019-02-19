#!/bin/bash

# Variables
CC="gcc"
FLAGS="-Wall -O0"
OFILE="main.o"
SFILE="main.s"
OUTFILE="main.out"
COUNTERA=1000

# Clean up previous intermediate files
rm -f $OFILE $SFILE $OUTFILE

echo "Making code to attempt to overload branch table buffer"
# Start off the file with preamble.s. A single '>' overwrites contents.
cat preamble.s > $SFILE

# %eax will hold $1
echo "movl \$1, %eax" >> $SFILE
# The dollar sign needs to be escaped because it indicates the start of 
# a variable in bash

# This is the code to insert arbitrary instructions into main.s. COUNTERA
# contains the number of times to run a block that consists of the following:
# 1) A pre-test branch
# 2) Some arbitrarily long unit of work
# COUNTERB controls exactly how much work will be attempted in step 2)
until [ $COUNTERA -lt 1 ]; do
    echo "cmp \$0, %eax" >> $SFILE		# Test for 0 - 1
    echo "je .ACC0 " >> $SFILE			# If 1 == 0, jump to .ACC0 (See footer.s)
    COUNTERB=100				# Number of times to carry out FP mult.
    until [ $COUNTERB -lt 1 ]; do		# Inner loop to do work
        echo "mulsd %xmm0, %xmm1" >> $SFILE	# Do the work
        let COUNTERB-=1				# Decrement work counter
    done
    let COUNTERA-=1
done

# Append footer.s to the file to make it complete. Double '>>' appends, rather
# than overwrites, the contents in a file.
cat footer.s >> $SFILE

# Attempt to compile the code
# First, generate the .o file
$CC $FLAGS -o $OFILE -c $SFILE
# Second, link and generate executable
$CC $FLAGS -o $OUTFILE $OFILE

set -x # Set echo on

# Run the file and time it
time ./$OUTFILE
