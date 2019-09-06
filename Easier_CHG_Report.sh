#!/bin/bash
gcsplit --digits=2  --quiet --prefix=outfile changes "/CHG/" "{*}"
#while loop here to go through all outfile0*
gsed -i '2,3d' outfile01
gsed -i '3,5d' outfile01
gsed -i '4,5d' outfile01
gsed -i ':a;N;$!ba;s/\n//g' outfile01
gsed -i 's/\t/\ /g' outfile01

#at the end:
#rm outfile0*
