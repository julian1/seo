<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gco="http://www.isotc211.org/2005/gco" 
	xmlns:gmd="http://www.isotc211.org/2005/gmd" 
	xmlns:gmx="http://www.isotc211.org/2005/gmx" 
>


	<xsl:template match="mcp:MD_Metadata">
	  <html>
	  <body>
	  <h2>My CD Collection</h2>

	  <!-- xsl:apply-templates select="//gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]" /-->

	  <xsl:for-each select="//gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword" >

			whoo <xsl:value-of select="." /> 


	  </xsl:for-each> 

	  </body>
	  </html>
	</xsl:template>

	<!-- Ok, think we should perhaps be gathering up variables --> 


	<!-- xsl:template match="gmx:Anchor">
		<h2> HERE : <xsl:value-of select="./ancestor::gmd:MD_Keywords" /> </h2>
	</xsl:template -->



</xsl:stylesheet>

