<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gco="http://www.isotc211.org/2005/gco" 
  xmlns:gmd="http://www.isotc211.org/2005/gmd" 
  xmlns:gmx="http://www.isotc211.org/2005/gmx" 
>



  <xsl:template match="mcp:MD_Metadata">


      <xsl:variable name="waterBodies" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />
     

  <!-- gmd:contact>
    <gmd:CI_ResponsibleParty>
      <gmd:organisationName>
        <gco:CharacterString>eMarine Information Infrastructure (eMII)</gco:CharacterString 

  <gmd:identificationInfo>
    <mcp:MD_DataIdentification gco:isoType="gmd:MD_DataIdentification">
      <gmd:descriptiveKeywords>
        <gmd:MD_Keywords>
          <gmd:type>
            <gmd:MD_KeywordTypeCode codeList="http://schemas.aodn.org.au/mcp-2.0/schema/resources/Codelist/gmxCodelists.xml#MD_KeywordTypeCode" codeListValue="theme">theme</gmd:MD_KeywordTypeCode>
          </gmd:type>
          <gmd:thesaurusName>

  -->
 
 
      <xsl:variable name="organisation" select="gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString" />


      organisation---  '<xsl:value-of select="$organisation" separator=", " />'

      <!-- xsl:variable name="parameters" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName/mcp:DP_Term/mcp:term/gco:CharacterString" / -->
      <xsl:variable name="parameters" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter" />





      <!-- xsl:variable name="platforms" select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:platform/mcp:DP_Term/mcp:term/gco:CharacterString" / -->


        <!-- xsl:value-of select="/root/item" separator="', '"/ -->


        water bodies: <xsl:value-of select="$waterBodies" separator=", "/>


      <!-- 
        parameters : '<xsl:value-of select="$parameters" separator="', '"/>'
        platforms : '<xsl:value-of select="$platforms" separator="', '"/>'
        water bodies2:
      -->

        <xsl:for-each select="$parameters" >

          <!-- this should restrict code list as well as longName -->
          <xsl:variable name="parameter" select="mcp:parameterName/mcp:DP_Term/mcp:type/mcp:DP_TypeCode[text() = 'longName']/../../mcp:term/gco:CharacterString" />

          <xsl:variable name="platform" select="mcp:platform/mcp:DP_Term/mcp:term/gco:CharacterString" />

          <xsl:variable name="filename" select='encode-for-uri( replace($parameter, " ","-"))'/>

          parameter     '<xsl:value-of select="$parameter" />'
          platform      '<xsl:value-of select="$platform" />'
          filename      '<xsl:value-of select="$filename" />'
          organisation  '<xsl:value-of select="$organisation" separator=", " />'



          <xsl:result-document method="xml" href="output/{$filename}.html">

            <xsl:text>&#xa;</xsl:text>
            <html>
            <head>

              <xsl:text>&#xa;</xsl:text>

              <title>
                <xsl:value-of select="$parameter" />
                <xsl:text> </xsl:text>
                <xsl:value-of select="$waterBodies" separator=", "/>
                <xsl:text> </xsl:text>
                <!-- land masses -->
                <xsl:text> </xsl:text>
                <xsl:value-of select="$platform" />
                <xsl:text> IMOS Scientific Research Data </xsl:text>
                <xsl:value-of select="$organisation" />

              </title>

              <xsl:text>&#xa;</xsl:text>
            </head>
            </html>
          </xsl:result-document>

        </xsl:for-each> 


  </xsl:template>


</xsl:stylesheet>

