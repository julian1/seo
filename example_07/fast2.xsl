<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"
  xmlns:geonet="http://www.fao.org/geonetwork"

  exclude-result-prefixes="xsl mcp gco gmd gmx"
>


  <!-- xsl:include href="view.xsl" / -->


  <xsl:variable name="geonetworkUrl" select="'https://catalogue-123.aodn.org.au'"/>

  <!-- this thing ought to match the original file -->

  <xsl:template match="mcp:MD_Metadata">
    <xsl:value-of select="'WHOOT!!!'" />
  </xsl:template>


  <xsl:template match="/">
	  <xsl:apply-templates select="document('https://catalogue-123.aodn.org.au/geonetwork/srv/eng/xml.metadata.get?uuid=c1344979-f701-0916-e044-00144f7bc0f4' )/mcp:MD_Metadata"/>
  </xsl:template>

</xsl:stylesheet>

