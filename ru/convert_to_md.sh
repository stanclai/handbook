#!/bin/bash

if [ -z $1 ] ; then
        BOOK_DIR=.
else
    	BOOK_DIR=$1
fi

if [ ! -d $BOOK_DIR ] ; then
        mkdir $BOOK_DIR
fi

declare -A CHAPTERS=()
[ -f chapters.inc ] && . chapters.inc

rm -f ${BOOK_DIR}/book.md

# Only set if not overriden by an environment variable
DATE=${DATE:-`date +%F`}

echo "Справочник по проведеню криптовечеринок" >> ${BOOK_DIR}/book.md
echo "=======================================" >> ${BOOK_DIR}/book.md
echo "Версия ${DATE}" >> ${BOOK_DIR}/book.md
echo "" >> ${BOOK_DIR}/book.md

for d in chapter_*; do
        if [ ${#CHAPTERS[*]} == 0 ]; then
            TITLE=`echo ${d} | sed 's/chapter_[0-9][0-9]_//; s/_/ /g; s/^./\U&/;'`
        else
            TITLE=${CHAPTERS[$d]}
        fi
        TITLEUNDERLINE=`echo $TITLE | sed 's/./=/g'`
        echo ${TITLE} >> ${BOOK_DIR}/book.md
        echo ${TITLEUNDERLINE} >> ${BOOK_DIR}/book.md
        echo "" >> ${BOOK_DIR}/book.md;
	for file in ${d}/*.md; do
	        cat "${file}" >> ${BOOK_DIR}/book.md;
	        echo "" >> ${BOOK_DIR}/book.md;
	        echo "" >> ${BOOK_DIR}/book.md;
	done
done
