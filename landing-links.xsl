<?xml version="1.0" encoding="UTF-8"?>

<!-- Now parametized
  https://10.11.12.13/geonetwork/srv/eng/metadata.formatter.html?uuid=4402cb50-e20a-44ee-93e6-4728259250d2&xsl=landing-links

  or
  Note it works for either input because of root

  java -jar saxon9he.jar records/argo_with_wb_and_lm.xml  landing-links.xs
-->

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"

  exclude-result-prefixes="xsl mcp gco gmd gmx"
>


  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />



  <!-- match root node, when running in geonetwork -->
  <xsl:template match="root">
      <xsl:apply-templates select="mcp:MD_Metadata"/>
  </xsl:template>



  <xsl:template match="mcp:MD_Metadata">

    <xsl:variable name="uuid" select="gmd:fileIdentifier/gco:CharacterString"/>

    <!-- Data identification is a common root and should be factored -->
    <xsl:variable name="waterBodies" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water-bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />

    <xsl:variable name="landMasses" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.land-masses' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />

    <xsl:variable name="parameters" select="gmd:identificationInfo/mcp:MD_DataIdentification/mcp:dataParameters/mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter" />

    <xsl:variable name="title" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />

    <xsl:variable name="abstract" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:abstract/gco:CharacterString" />

    <xsl:variable name="organisation" select="gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString" />

    <!--
    uuid :        '<xsl:value-of select="$uuid"/>'
    organisation: '<xsl:value-of select="$organisation"/>'
    water bodies: '<xsl:value-of select="$waterBodies" separator="', '"/>'
    land masses:  '<xsl:value-of select="$landMasses" separator="', '"/>'
    title:        '<xsl:value-of select="$title" />'
    abstract:     '<xsl:value-of select="$abstract" />'
    -->


    <html>
      <head>
        <title>List of parameters, The eMarine Information Infrastructure (eMII)</title>
        <meta charset="utf-8"/>
        <meta name="description" content="List of parameters, The eMarine Information Infrastructure (eMII)"/>
      </head>
      <body>
        <h1> 
          <xsl:value-of select='$title'/>
        </h1>
        <ul>
          <xsl:for-each select="$parameters">

            <xsl:variable name="paramIndex" select="position() - 1"/>
            <xsl:variable name="parameter" select="mcp:parameterName/mcp:DP_Term/mcp:type/mcp:DP_TypeCode[text() = 'longName']/../../mcp:term/gco:CharacterString" />

           <xsl:variable name="href">
              <xsl:value-of select="'metadata.formatter.html?uuid='"/>
              <xsl:value-of select="$uuid"/>
              <xsl:value-of select="'&amp;xsl=landing-page'"/>
              <xsl:value-of select="'&amp;paramIndex='"/>
              <xsl:value-of select="$paramIndex"/>
            </xsl:variable>

            <!-- eg. metadata.formatter.html?uuid=4402cb50-e20a-44ee-93e6-4728259250d2&xsl=landing-page&paramIndex=1  -->

            <li>
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="$href"/>
                </xsl:attribute>
                <xsl:value-of select='$parameter'/>
              </xsl:element>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>


  </xsl:template>

</xsl:stylesheet>

