<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gco="http://www.isotc211.org/2005/gco" 
  xmlns:gmd="http://www.isotc211.org/2005/gmd" 
  xmlns:gmx="http://www.isotc211.org/2005/gmx" 
>



  <xsl:template match="mcp:MD_Metadata">


      <xsl:variable name="waterBodies" select="//gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />
      
      <xsl:variable name="organisation" select="//gmd:identificationInfo//gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString" />

      <xsl:variable name="parameters" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName/mcp:DP_Term/mcp:term/gco:CharacterString" />


      <xsl:variable name="platforms" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:platform/mcp:DP_Term/mcp:term/gco:CharacterString" />


        <!-- xsl:value-of select="/root/item" separator="', '"/ -->


        water bodies: <xsl:value-of select="$waterBodies"/>


      <!-- 
        parameters : '<xsl:value-of select="$parameters" separator="', '"/>'
        platforms : '<xsl:value-of select="$platforms" separator="', '"/>'
        water bodies2:
      -->

        <xsl:for-each select="$parameters" >
          <xsl:variable name="parameter" select="string(.)"/>
          <xsl:variable name="filename" select='replace($parameter, " ","-")'/>

          <xsl:result-document method="xml" href="output/{$filename}.html">
            <html>
            <head>

              <title>


                <xsl:value-of select="$parameter" />

              </title>

            </head>
            </html>


                      WHOOT

          </xsl:result-document>
        </xsl:for-each> 


  </xsl:template>


</xsl:stylesheet>

