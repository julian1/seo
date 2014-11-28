<?xml version="1.0" encoding="UTF-8"?>

<!-- java -jar ../saxon9he.jar  ../records/argo_with_wb_and_lm.xml view2.xsl -->

<!-- 
	Note that Saxon - doesn't like the SSL self-signed certificate when running in vagrant instance

'http://10.11.12.13/geonetwork/srv/en/xml.search.keywordlink?request=broader&amp;thesaurus=external.theme.parameterClassificationScheme&amp;id=http://vocab.nerc.ac.uk/collection/P01/current/PSLTZZ01'"/>
-->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"

  exclude-result-prefixes="xsl mcp gco gmd gmx"
>


	<!-- xsl:variable name="href" select="http://10.11.12.13"/ -->
	

  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />


  <xsl:variable name="geonetworkUrl" select="'http://10.11.12.13'"/>
  <xsl:variable name="thesaurus" select="'external.theme.parameterClassificationScheme'"/>
  <xsl:variable name="term" select="'http://vocab.nerc.ac.uk/collection/P01/current/PSLTZZ01'"/>

  <xsl:variable name="request" select="string-join(($geonetworkUrl, '/geonetwork/srv/en/xml.search.keywordlink?request=broader&amp;thesaurus=', $thesaurus, '&amp;id=', $term ),'')" />


  <xsl:template match="mcp:MD_Metadata">

    <xsl:variable name="broader" select="document($request)/response/narrower/descKeys/keyword/values/value[@language='eng']"  />
    <xsl:value-of select="$broader" />
  </xsl:template>

</xsl:stylesheet>

