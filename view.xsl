<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gco="http://www.isotc211.org/2005/gco" 
	xmlns:gmd="http://www.isotc211.org/2005/gmd" 
>

	<!-- eg. xsltproc view.xsl formatter-input.xml --> 


	<xsl:template match="mcp:MD_Metadata">
	  <html>
	  <body>
	  <h2>My CD Collection</h2>

	  <xsl:apply-templates select="gmd:parentIdentifier" />
	  <xsl:apply-templates select="gmd:fileIdentifier" />
	  <xsl:apply-templates select="//mcp:parameterName" />

	  <xsl:apply-templates select="//gmd:thesaurusName" />
	  </body>
	  </html>
	</xsl:template>



	<xsl:template match="gmd:fileIdentifier">
	<h2> fileIdentifier: <xsl:value-of select="gco:CharacterString" /> </h2>
	</xsl:template>


	<xsl:template match="gmd:parentIdentifier">
	<!-- xsl:template match="gmd:parentIdentifier" -->
	<h2> parentIdentifier: <xsl:value-of select="gco:CharacterString" /> </h2>
	</xsl:template>

	<xsl:template match="mcp:parameterName">
	<h2> parameter : <xsl:value-of select="mcp:DP_Term/mcp:term/gco:CharacterString" /> </h2>
	</xsl:template>





	<xsl:template match="gmd:thesaurusName">
	<!-- h2> thesaurus : <xsl:value-of select="gmd:CI_Citation//gmx:Anchor" /> </h2 -->
	<!-- h2> thesaurus : <xsl:value-of select=".//gmx:Anchor" /> </h2-->
	<h2> thesaurus : <xsl:value-of select="gmd:CI_Citation/gmd:title/gco:CharacterString" /> </h2>
	</xsl:template>


	

     <!-- 

		gmx:Anchor	

	'//gmd:thesaurusName//gmx:Anchor/text()'

		mcp:dataParameters/mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName
	-->





</xsl:stylesheet>

