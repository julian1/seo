set -x
rm output* -rf 2> /dev/null
java -jar ../saxon9he.jar  ./dummy.xml records-process.xsl
#java -jar ../saxon9he.jar  ../records/argo_with_wb_and_lm.xml view.xsl 
cp imos.css output
tar czf output.tgz output/
