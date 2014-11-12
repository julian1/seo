<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gco="http://www.isotc211.org/2005/gco" 
	xmlns:gmd="http://www.isotc211.org/2005/gmd" 
	xmlns:gmx="http://www.isotc211.org/2005/gmx" 
>

	<!-- eg. xsltproc view.xsl formatter-input.xml --> 


	<xsl:template match="mcp:MD_Metadata">
	  <html>
	  <body>
	  <h2>My CD Collection</h2>

	  <xsl:apply-templates select="gmd:parentIdentifier" />
	  <xsl:apply-templates select="gmd:fileIdentifier" />
	  <xsl:apply-templates select="//mcp:parameterName" />

	  <!-- xsl:apply-templates select="//gmd:thesaurusName" / -->

	  <xsl:apply-templates select="//gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]" />

	  </body>
	  </html>
	</xsl:template>

	<!-- Ok, think we should perhaps be gathering up variables --> 


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


	<xsl:template match="mcp:parameterName">
		<h2> parameter : <xsl:value-of select="mcp:DP_Term/mcp:term/gco:CharacterString" /> </h2>
	</xsl:template>


	<xsl:template match="gmx:Anchor">
		<h2> HERE : <xsl:value-of select="." /> </h2>
	</xsl:template>




	<!-- ok, lets try and match and then back up  -->

	<!-- xsl:template match="gmd:thesaurusName">
		<h2> WHOOT thesaurus : <xsl:value-of select="gmd:CI_Citation/gmd:title/gco:CharacterString" /> </h2>
		<xsl:if test="gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gmx:Anchor">
			<h2> WHOOT2 thesaurus : <xsl:value-of select="gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gmx:Anchor" /> </h2>
		</xsl:if>
	</xsl:template -->


	

     <!-- 

		gmx:Anchor	

	'//gmd:thesaurusName//gmx:Anchor/text()'

		mcp:dataParameters/mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName
	-->





</xsl:stylesheet>

