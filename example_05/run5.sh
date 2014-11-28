set -x
rm output* -rf 2> /dev/null
java -jar ../saxon9he.jar  ../records/argo_with_wb_and_lm.xml view5.xsl 
tar czf output.tgz output/
