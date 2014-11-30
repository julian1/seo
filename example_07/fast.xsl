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

<!-- 
	<xsl:include href="translate_newlines.xsl" />
	<xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />

	https://10.11.12.13/geonetwork/srv/eng/xml.search.imos?fast=index

<xsl:variable name="request" select="string-join(($geonetworkUrl, '/geonetwork/srv/en/xml.search.keywordlink?request=broader&amp;thesaurus=', $thesaurus, '&amp;id=', $term ),'')" />
<xsl:variable name="request" select="'https://10.11.12.13/geonetwork/srv/eng/xml.search.imos?fast=index'"/>

	dd  <xsl:for-each select="$waterBodies">
-->

<xsl:variable name="request" select="'https://catalogue-123.aodn.org.au/geonetwork/srv/eng/xml.search.imos?fast=index'"/>

<xsl:template match="/">

	<xsl:for-each select="document($request)/response/metadata" >


		<xsl:text>&#xa;</xsl:text> 
		<xsl:value-of select="title" />

		<xsl:text>,  </xsl:text> 
		<!-- xsl:value-of select="../geonet:info/uuid" /-->

		<xsl:value-of select="responsibleParty" />


		<!-- geonet:info xmlns:geonet="http://www.fao.org/geonetwork" -->
		<xsl:value-of select="geonet:info"/>

	</xsl:for-each>


</xsl:template>


</xsl:stylesheet>

