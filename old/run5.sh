set -x
rm output/* 2> /dev/null
rm output.tgz  2> /dev/null
java -jar saxon9he.jar  argo_with_wb_and_lm.xml view5.xsl 
tar czf output.tgz output/
