set -x
rm output/* 2> /dev/null
java -jar saxon9he.jar  argo_with_wb_and_lm.xml view3.xsl 
