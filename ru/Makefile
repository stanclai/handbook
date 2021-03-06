BUILD_DIR=build
DIST_DIR=../dist

TEX_DIR=${BUILD_DIR}/tex
BOOK_DIR=${BUILD_DIR}/.

# Only set if not overriden by an environment variable
DATE?=`date +%F`

BOOK_NAME=cryptoparty-handbook-ru-${DATE}

all: latex-pdf combined

${BUILD_DIR}:
	mkdir ${BUILD_DIR}

${DIST_DIR}:
	mkdir ${DIST_DIR}

${TEX_DIR}/main.tex: ${BUILD_DIR} convert_to_tex.sh
	./convert_to_tex.sh ${TEX_DIR}

latex-pdf: ${TEX_DIR}/main.tex
	pdflatex --output-dir=${TEX_DIR} ${TEX_DIR}/main.tex >/dev/null
	# The second run will fix the TOC
	pdflatex --output-dir=${TEX_DIR} ${TEX_DIR}/main.tex >/dev/null

${BOOK_DIR}/book.md: ${BUILD_DIR}
	./convert_to_md.sh ${BOOK_DIR}

combined: ${BOOK_DIR}/book.md

install: combined latex-pdf ${DIST_DIR}
	cp ${TEX_DIR}/main.pdf ${BOOK_DIR}/../${DIST_DIR}/${BOOK_NAME}.pdf
	cp ${BOOK_DIR}/book.md ${BOOK_DIR}/../${DIST_DIR}/${BOOK_NAME}.md
	./convert_to_epub.sh
	./convert_to_html.sh
	(cd ${DIST_DIR}; zip -9qr ${BOOK_NAME}-html.zip ${BOOK_NAME})
	(cd ${DIST_DIR}; sha256sum ${BOOK_NAME}.* ${BOOK_NAME}-html.zip > SHA256SUM)

clean: ${BUILD_DIR}
	rm -Rf ${BUILD_DIR}/*
	find -type l -delete
