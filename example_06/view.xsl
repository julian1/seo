<?xml version="1.0" encoding="UTF-8"?>

<!-- java -jar ../saxon9he.jar  ../records/argo_with_wb_and_lm.xml view.xsl --> 

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"

  xmlns:http="http://expath.org/ns/http-client"

  exclude-result-prefixes="xsl mcp gco gmd gmx"
>


  <!-- The request element to get Google page. -->
  <xsl:variable name="req" as="element()">
    <http:request href="http://www.google.com/" method="get"/>
  </xsl:variable>



  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />

  <xsl:template match="mcp:MD_Metadata">
    <!-- xsl:value-of select="$req"/ -->

    <!-- xsl:value-of select="document('http://www.google.com/')"/ -->

    <xsl:copy-of select="document( 'http://maps.google.com/maps/api/geocode/xml?address=CV344SA,UK&amp;sensor=false' )" />


    <!-- xsl:copy-of select="document('http://www.google.com/')"/ --> 

  </xsl:template>



</xsl:stylesheet>

