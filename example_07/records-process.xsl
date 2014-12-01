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


<xsl:include href="view.xsl" />


<xsl:variable name="geonetworkUrl" select="'https://catalogue-123.aodn.org.au'"/>


<xsl:variable name="request" select="concat($geonetworkUrl, '/geonetwork/srv/eng/xml.search.imos?fast=index')"/>

  <!-- TODO: we don't need to match on an empty document -->
  <xsl:template match="/">
    <xsl:for-each select="document($request)/response/metadata" >

      <xsl:variable name="schema" select="geonet:info/schema"/>

      <xsl:value-of select="concat( '&#xa;', $schema, ', ', position(), ', ' )" />

      <xsl:if test="$schema = 'iso19139.mcp-2.0' and position() &lt; 5">

        <xsl:variable name="uuid" select="geonet:info/uuid"/>
        <xsl:variable name="request2" select="concat($geonetworkUrl, '/geonetwork/srv/eng/xml.metadata.get?uuid=', $uuid)" />

        <xsl:value-of select="concat( $uuid, ', ', position(), ', ', $request2 )" />

        <xsl:apply-templates select="document($request2)/mcp:MD_Metadata"/>
      </xsl:if>
    </xsl:for-each>

  </xsl:template>
</xsl:stylesheet>

