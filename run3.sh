set -x
rm output/*
java -jar saxon9he.jar  argo_profiles_with_water_bodies.xml view3.xsl 
