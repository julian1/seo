<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"
  xmlns:geonet="http://www.fao.org/geonetwork"

  exclude-result-prefixes="xsl mcp gco gmd gmx geonet"
>



  <xsl:template match="mcp:MD_Metadata">

    <xsl:element name="mcp:MD_Metadata"> 
      <xsl:value-of select="."/>
    </xsl:element> 

  </xsl:template>





  <!-- xsl:include href="record-view.xsl" / -->

  <xsl:variable name="geonetworkUrl" select="'https://catalogue-123.aodn.org.au'"/>
  <xsl:variable name="request" select="concat($geonetworkUrl, '/geonetwork/srv/eng/xml.search.imos?fast=index')"/>
  <!-- cache the node, to guarantee idempotence --> 
  <xsl:variable name="node" select="document($request)/response/metadata"/>


  <!-- filename generation should be predictable here. 
    so apply templates with param.
  -->

  <!-- TODO: we don't need to match on an empty document -->
  <xsl:template match="/">

    <!-- output records -->
    <xsl:for-each select="$node" >

      <xsl:variable name="schema" select="geonet:info/schema"/>
      <xsl:value-of select="concat( '&#xa;', $schema, ', ', position(), ', ' )" />

      <xsl:if test="$schema = 'iso19139.mcp-2.0' and position() &lt; 5">

        <!-- we're going to have to call the template -->
<!--        <xsl:variable name="filename">
          <xsl:call-template name="record-filename" select="document($request2)/mcp:MD_Metadata"/>
        </xsl:variable>
-->

        <xsl:variable name="uuid" select="geonet:info/uuid"/>
        <xsl:variable name="request2" select="concat($geonetworkUrl, '/geonetwork/srv/eng/xml.metadata.get?uuid=', $uuid)" />
        <xsl:value-of select="concat( $uuid, ', ', position(), ', ', $request2 )" />

        <!-- xsl:apply-templates select="document($request2)/mcp:MD_Metadata"/ -->
        <!-- xsl:variable name="node" select="document($request2)/mcp:MD_Metadata"/-->

        <xsl:variable name="whoot"> 
          <xsl:apply-templates select="document($request2)/mcp:MD_Metadata"/>
        </xsl:variable> 

        <xsl:value-of select="$whoot/mcp:MD_Metadata"/>

      </xsl:if>
    </xsl:for-each>



    <!-- output an index file -->
    <xsl:result-document method="xml" href="output/index.html">
      <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <html>
        <head>
          <title>List of parameters, The eMarine Information Infrastructure (eMII)</title>
          <meta charset="utf-8"/>
          <meta name="description" content="List of parameters, The eMarine Information Infrastructure (eMII)"/>
        </head>
        <body>

          <xsl:for-each select="$node" >

            <xsl:variable name="xxx" select="'xxx'"/>

            <xsl:element name="a">
              <xsl:attribute name="href">
                <xsl:value-of select="encode-for-uri( $xxx)"/>
              </xsl:attribute>
              <xsl:value-of select="$xxx"/>
            </xsl:element>

           </xsl:for-each>

        </body>
      </html>
    </xsl:result-document>


  </xsl:template>
</xsl:stylesheet>

