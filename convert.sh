#!/bin/bash

echo "converting png in sources/ to pdf & txt"
echo "---------------------------------------"

for i in sources/*.png
do
  tesseract "$i" "${i%.png}" -l fra --psm 3 txt pdf
done

rm sources/*.osd

echo "---------------------------------------"
echo "merging txt files to perec-ulcérations.txt and perec-ulcérations-contrainte.txt"

cat sources/ulcérations.[1-9].txt > perec-ulcérations.txt
rm sources/ulcérations.*.txt

cat sources/ulcérations-contrainte.*.txt > perec-ulcérations-contrainte.txt
rm sources/ulcérations-contrainte.*.txt

# editing
sed -i \
  -e 's/\f//g' \
  -e 's/— *[[:digit:]]\+—//g' \
  -e 's/_//g' \
  perec-ulcérations.txt

echo "Georges Perec"      >> tmp
echo ""                   >> tmp
echo "Ulcérations"        >> tmp
cat perec-ulcérations.txt >> tmp
mv tmp perec-ulcérations.txt

sed -i \
  -e 's/\f//g' \
  -e '/—[[:digit:]]\+—/d' \
  -e '/^$/d' \
  -e '/^[[:digit:]]\+$/d' \
  -e 's/^8/3/' \
  -e 's/^3891/391/' \
  perec-ulcérations-contrainte.txt

echo "merging pdf files to perec-ulcérations.pdf"

gs \
  -sDEVICE=pdfwrite \
  -dCompatibilityLevel=1.4 \
  -dPDFSETTINGS=/default \
  -dNOPAUSE \
  -dQUIET \
  -dBATCH \
  -dDetectDuplicateImages \
  -dCompressFonts=true \
  -r150 \
  -sOutputFile="perec-ulcérations.pdf" \
  sources/*.pdf
rm sources/*.pdf

echo "done!"
echo "---------------------------------------"
