<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gco="http://www.isotc211.org/2005/gco" 
	xmlns:gmd="http://www.isotc211.org/2005/gmd" 
>

  <!-- xsl:include href="../base-layout.xsl"/>
  <xsl:template mode="content" match="/">
    <div data-ng-include="'{$uiResourcesPath}templates/search/search.html'">
    </div>
  </xsl:template -->
	<!-- gmd:fileIdentifier>
		<gco:CharacterString
	-->



	<xsl:template match="mcp:MD_Metadata">
	<html>
	<h2>
		<xsl:value-of select="gmd:fileIdentifier" />
	</h2>

		<xsl:value-of select="gmd:parentIdentifier" />


	</html>
	</xsl:template>


</xsl:stylesheet>
