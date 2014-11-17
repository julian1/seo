<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gco="http://www.isotc211.org/2005/gco" 
  xmlns:gmd="http://www.isotc211.org/2005/gmd" 
  xmlns:gmx="http://www.isotc211.org/2005/gmx" 
>


      <xsl:param name="target"/> 

  <xsl:template match="mcp:MD_Metadata">


      <xsl:variable name="waterBodies" select="//gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />
      
      <xsl:variable name="organisation" select="//gmd:identificationInfo//gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString" />

      <xsl:variable name="parameters" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName/mcp:DP_Term/mcp:term/gco:CharacterString" />


      <xsl:variable name="platforms" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:platform/mcp:DP_Term/mcp:term/gco:CharacterString" />


      <!-- can we simplify this dynamically? -->
      <xsl:variable name="parameterExists" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName/mcp:DP_Term/mcp:term/gco:CharacterString=$target" />

    <!-- xsl:value-of select="/root/item" separator="', '"/ -->


        water bodies: <xsl:value-of select="$waterBodies" separator="', '"/>

        parameters : '<xsl:value-of select="$parameters" separator="', '"/>'

        platforms : '<xsl:value-of select="$platforms" separator="', '"/>'

        water bodies2:

        <xsl:for-each select="$parameters" >
          <xsl:variable name="parameter" select="string(.)"/>

          <xsl:value-of select="$parameter" />

           <xsl:value-of select='replace($parameter, " ","-")'/>


        </xsl:for-each> 





  </xsl:template>


</xsl:stylesheet>

