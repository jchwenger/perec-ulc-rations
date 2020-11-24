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
  -e 's/^(Fours/   (l’ours/' \
  -e 's/^scout/   scout/' \
  -e 's/^scout/   scout/' \
  -e 's/^sourcier,/   sourcier,/' \
  -e 's/^aliénation)/                aliénation)/' \
  -e 's/^tartine,/           tartine,/' \
  -e 's/^cal ou sceau)./           cal ou sceau)./' \
  -e 's/^(cicatrisé/     (cicatrisé/' \
  -e 's/^rature/                  rature/' \
  -e 's/^clin/                  clin/' \
  -e 's/^ossature.)/                  ossature.)/' \
  -e 's/^oui...)/           oui...)/' \
  -e 's/^latrine (closet ri)/latrine        (closet ri)/' \
  -e 's/^latrine (closet ri)/latrine        (closet ri)/' \
  -e 's/lancestral/l’ancestral/' \
  -e 's/^union (ou lit)/          union        (ou lit)/' \
  -e 's/^sacrée,/          sacrée,/' \
  -e 's/^il sue/     il sue/' \
  -e 's/^si l’outil/     si l’outil/' \
  -e 's/^ton cuir./     ton cuir./' \
  -e 's/^clou,/           clou,/' \
  -e 's/^narcose/           narcose/' \
  -e 's/^(trace/     (trace/' \
  -e 's/^souci/     souci/' \
  -e 's/^la sinécure,/             la sinécure,/' \
  -e 's/^sa lointaine/             sa lointaine/' \
  -e 's/^scrotulaire,/                scrotulaire,/' \
  -e 's/^son culte,/             son culte,/' \
  -e 's/^son ail turc —)/             son ail turc —)/' \
  -e 's/^(tu l’isoles/        (tu l’isoles/' \
  -e 's/^(satin,/     (satin,/' \
  -e 's/^rat sec,/     rat sec,/' \
  -e 's/^nouille/     nouille/' \
  -e 's/^clonus,/     clonus,/' \
  -e 's/^article tû,/     article tû,/' \
  -e 's/^raison...),/     raison...),/' \
  -e 's/^cuisant/     cuisant/' \
  -e 's/^ne court)/     ne court)/' \
  -e 's/^une oscillation/     une oscillation/' \
  -e 's/^crue sous/         crue sous/' \
  -e 's/^Panticréation./     Panticréation./' \
  -e 's/^ce sûr lin seul à/     ce sûr lin seul à/' \
  -e 's/^trocart),/         trocart),/' \
  -e 's/^les couinants,/     les couinants,/' \
  -e 's/^l’écroui./     l’écroui./' \
  -e 's/^ça tonsure,/               ça tonsure,/' \
  -e 's/^ça sourt./               ça sourt./' \
  -e 's/^on caille/              on caille/' \
  -e 's/^son urticaire,/    son urticaire,/' \
  -e 's/^ton Lucas-Carton../    ton Lucas-Carton.../' \
  -e 's/^(un lac — Ontario/    (un lac — Ontario/' \
  -e 's/^écluse ton cas :/    écluse ton cas :/' \
  -e 's/^Purinoir tel)/    Purinoir tel)/' \
  -e 's/^raclent, licou ras)/    raclent, licou ras)/' \
  -e 's/^un écart./      un écart./' \
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
