<?xml version="1.0" encoding="UTF-8"?>
<!-- works https://10.11.12.13/geonetwork/srv/eng/metadata.formatter.xml?uuid=4402cb50-e20a-44ee-93e6-4728259250d2&xsl=view15 -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"

  exclude-result-prefixes="xsl mcp gco gmd gmx"
>

<xsl:template match="root">

    <html>
    <xsl:variable name="uuid" select="mcp:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
    <xsl:value-of select="$uuid" />
    </html>

</xsl:template>

</xsl:stylesheet>

