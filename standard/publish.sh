#!/bin/bash

DOCNUM="$1"
DOC_TYPE="is"
STATUS="$2"

usage()
{
    echo "usage: publish.sh [[[-d DOC_NUMBER ] [-t DOC_TYPE] [-s STATUS]] | [-h]]"
}

#### MAIN

while [ "$1" != "" ]; do
    case $1 in
        -d | --DOCNUM )         shift
                                DOCNUM="$1"
                                ;;
        -t | --DOC_TYPE )       shift
				DOC_TYPE="$1"
                                ;;
        -s | --STATUS )         shift
				STATUS="$1"
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

echo "Getting the Latest Metanorma instance .... "		
docker pull metanorma/mn:latest

echo "Running Metanorma Docker .... "		
docker run -v "$(pwd)":/metanorma metanorma/mn  metanorma compile -t ogc -x xml,html,doc,pdf --agree-to-terms  $DOCNUM.adoc

if [[ $STATUS = "DRAFT" ]]
then
	echo "Adding DRAFT Watermark to HTML.... "
	perl -i -p0e 's/-->\n<\/style>/#watermark\n{\n opacity:0.5;\n z-index:99;\n color:red;\n font-size: 6em;\n\n    width: 100px;\n    height: 100px;\n\n    position: fixed;\n    top:0;\n    bottom: 0;\n    left: 0;\n    right: 0;\n    margin: auto;\n}\n\n-->\n<\/style>/s' $DOCNUM.html
	perl -i -p0e 's/    <div class\=\"title-section\">/        <div id\=\"watermark\">DRAFT<\/div>\n    <div class\=\"title-section\">/s' $DOCNUM.html
fi

echo "Finished! "



