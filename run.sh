#!/bin/sh
echo "" > "index.md"
ii=0
jj=0
nn=10
for i in $(ls *.md);
do
  NAME=$(basename -s .md $i)
  if [ "${NAME}" != "index" ] && [ "${NAME}" != "readme" ]; then
    ((ii++)) 
    if [ $(expr $ii % $nn) == 1 ]; then
        ((jj++))
        if [ $jj != 1 ]; then
            echo "---" >> "index.md"
        fi

        echo "name:inverse" >> "index.md"
        echo "class: middle, inverse" >> "index.md"
        echo "# Index (page $jj)" >> "index.md"
    fi 
    cp page.tmpl ${NAME}.html
    sed -i '' "s/XXX/${i}/" ${NAME}.html
    echo " * $ii) [${NAME}](${NAME}.html)" >> "index.md"
  fi
done;

cp page.tmpl index.html
sed -i '' "s/XXX/index.md/" index.html

docker-compose up -d
# open index.html