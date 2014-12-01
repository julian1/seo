set -x
rm output* -rf 2> /dev/null
java -jar ../saxon9he.jar  ./dummy.xml records-process.xsl
cp imos.css output
tar czf output.tgz output/
