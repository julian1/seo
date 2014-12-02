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


  <!-- build an intermediate node with everything we'll need 
		we can actually push this into another file
		if we want.
    -->



  <xsl:template name="whoot">
    WHOOT
  </xsl:template>

  <xsl:template match="mcp:MD_Metadata">

    <xsl:variable name="uuid" select="gmd:fileIdentifier/gco:CharacterString"/>

    <!-- Data identification is a common root and should be factored -->
    <xsl:variable name="waterBodies" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water-bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />
/va
    <xsl:variable name="landMasses" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.land-masses' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />

    <xsl:variable name="parameters" select="gmd:identificationInfo/mcp:MD_DataIdentification/mcp:dataParameters/mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter" />

    <xsl:variable name="title" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />

    <xsl:variable name="abstract" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:abstract/gco:CharacterString" />

    <xsl:variable name="organisation" select="gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString" />

    <!-- take the right most element of the land mass separated by | -->
    <xsl:variable name="waterBodiesTidied">
      <xsl:for-each select="$waterBodies">
          <xsl:element name="water-body">
            <xsl:value-of select="replace(., '.*\|(.*)','$1')"/>
          </xsl:element>
      </xsl:for-each>
    </xsl:variable>

    <!-- take the right most element of the water body separated by | -->
    <xsl:variable name="landMassesTidied">
      <xsl:for-each select="$landMasses">
          <xsl:element name="land-mass">
            <xsl:value-of select="replace(., '.*\|(.*)','$1')"/>
          </xsl:element>
      </xsl:for-each>
    </xsl:variable>

    <!-- 
    uuid :        '<xsl:value-of select="$uuid"/>'
    organisation: '<xsl:value-of select="$organisation"/>'
    water bodies: '<xsl:value-of select="$waterBodies" separator="', '"/>'
    water bodies2: '<xsl:value-of select="$waterBodiesTidied/water-body" separator="', '"/>'
    land masses:  '<xsl:value-of select="$landMasses" separator="', '"/>'
    land masses2:  '<xsl:value-of select="$landMassesTidied/land-mass" separator="', '"/>'
    title:        '<xsl:value-of select="$title" />'
    -->
    <!-- abstract:     '<xsl:value-of select="$abstract" />' -->


    <xsl:variable name="geonetworkUrl" select="'http://10.11.12.13'"/>
    <xsl:variable name="thesaurus" select="'external.theme.parameterClassificationScheme'"/>


    <!-- Create a node with associated 2nd level category parameter names, and platform --> 
    <xsl:variable name="parameterList">
      <xsl:for-each select="$parameters" >

        <xsl:element name="longName">
          <xsl:value-of select="mcp:parameterName/mcp:DP_Term/mcp:type/mcp:DP_TypeCode[text() = 'longName']/../../mcp:term/gco:CharacterString" />
        </xsl:element>

        <xsl:element name="platform">
          <xsl:value-of select="mcp:platform/mcp:DP_Term/mcp:term/gco:CharacterString" />
        </xsl:element>

        <!-- TODO: change so it doesn't go via the long name -->
        <xsl:variable name="term" select="mcp:parameterName/mcp:DP_Term/mcp:type/mcp:DP_TypeCode[text() = 'longName']/../../mcp:vocabularyRelationship/mcp:DP_VocabularyRelationship/mcp:vocabularyTermURL/gmd:URL" />

        <xsl:variable name="request" select="string-join(($geonetworkUrl, '/geonetwork/srv/en/xml.search.keywordlink?request=broader&amp;thesaurus=', $thesaurus, '&amp;id=', $term ),'')" />

        <xsl:element name="broader">
          <xsl:value-of select="document($request)/response/narrower/descKeys/keyword/values/value[@language='eng']" />
        </xsl:element>

      </xsl:for-each>
    </xsl:variable>

    <!-- Group unique platforms -->
    <xsl:variable name="uniquePlatforms">
      <xsl:for-each-group select="$parameterList" group-by="platform">
        <xsl:element name="platform">
          <xsl:value-of select="current-grouping-key()"/>
        </xsl:element>
      </xsl:for-each-group>
    </xsl:variable>

    <!-- Group unique broader parameters -->
    <xsl:variable name="uniqueParameters">
      <xsl:for-each-group select="$parameterList" group-by="broader">
        <xsl:element name="broader">
          <xsl:value-of select="current-grouping-key()"/>
        </xsl:element>
      </xsl:for-each-group>
    </xsl:variable>

	  <!-- 
    <xsl:text>&#xa;      broader      &#xa;</xsl:text> 
    <xsl:value-of select="$parameterList/broader" separator=", "/>

    <xsl:text>&#xa;      longName      &#xa;</xsl:text> 
    <xsl:value-of select="$parameterList/longName" separator=", "/>

    <xsl:text>&#xa;      platform      &#xa;</xsl:text> 
    <xsl:value-of select="$parameterList/platform" separator=", "/>

    <xsl:text>&#xa;       uniquePlatforms       &#xa;</xsl:text> 
    <xsl:value-of select="$uniquePlatforms/platform" separator=", "/>

    <xsl:text>&#xa;       uniqueParameters      &#xa;</xsl:text> 
    <xsl:value-of select="$uniqueParameters/broader" separator=", "/>

    <xsl:text>&#xa;</xsl:text> 
	  --> 

    <xsl:variable name="filename">
      <xsl:value-of select="$title" separator="-"/>
      <xsl:text> | </xsl:text>
      <xsl:value-of select="$uniqueParameters/broader" separator="-"/>
      <xsl:text>.html</xsl:text>
    </xsl:variable>

    <!-- now create actual elements representing vars -->
    <xsl:element name="filename">
      <xsl:value-of select="replace( $filename, ' ', '-')" separator="-"/>
    </xsl:element>

    <xsl:element name="uuid">
      <xsl:value-of select="$uuid"/>
    </xsl:element>

  </xsl:template>





  <!-- xsl:include href="record-view.xsl" / -->

  <xsl:variable name="geonetworkUrl" select="'https://catalogue-123.aodn.org.au'"/>
  <xsl:variable name="request" select="concat($geonetworkUrl, '/geonetwork/srv/eng/xml.search.imos?fast=index')"/>
  <!-- cache the node, to guarantee idempotence --> 
  <xsl:variable name="nodes" select="document($request)/response/metadata"/>


  <!-- filename generation should be predictable here. 
    so apply templates with param.
  -->

  <!-- TODO: we don't need to match on an empty document -->
  <xsl:template match="/">


    <!-- build intermediate nodes -->
    <xsl:variable name="processedNodes">
      <xsl:for-each select="$nodes" >

        <xsl:variable name="schema" select="geonet:info/schema"/>
        <xsl:value-of select="concat( '&#xa;', $schema, ', ', position(), ', ' )" />

        <xsl:if test="$schema = 'iso19139.mcp-2.0' and position() &lt; 10">

          <xsl:variable name="uuid" select="geonet:info/uuid"/>
          <xsl:variable name="recordRequest" select="concat($geonetworkUrl, '/geonetwork/srv/eng/xml.metadata.get?uuid=', $uuid)" />
          <xsl:value-of select="concat( $uuid, ', ', position(), ', ', $recordRequest )" />

          <!-- build intermediate node -->
          <xsl:element name="node"> 
            <xsl:apply-templates select="document($recordRequest)/mcp:MD_Metadata"/>
          </xsl:element> 

        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <!-- change name node to record ??? -->

    <!-- test output some standard fields 
      factor into an output
    -->
    <xsl:for-each select="$processedNodes/node" >
      <xsl:text>&#xa;</xsl:text>
      <xsl:value-of select="filename"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="uuid"/>
    </xsl:for-each>


    <!-- build record view -->
    <xsl:for-each select="$processedNodes/node" >
      <xsl:variable name="filename" select="filename"/>

      <xsl:text>&#xa;</xsl:text>
      <xsl:text>filename is  </xsl:text>
      <xsl:value-of select="$filename"/>

      <!-- should expand by applying templates on node -->
      <xsl:result-document method="html" indent="yes" href="output/{ encode-for-uri( $filename)}">
        <xsl:call-template name="whoot"/>
      </xsl:result-document>

    </xsl:for-each>



    <!-- output an index file 
      factor into a template.
      should be the inner stuff independent of the result-document tags .
    -->
    <xsl:result-document method="html" indent="yes" href="output/index.html">

      <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <html>
        <head>
          <title>List of parameters, The eMarine Information Infrastructure (eMII)</title>
          <meta charset="utf-8"/>
          <meta name="description" content="List of parameters, The eMarine Information Infrastructure (eMII)"/>
        </head>
        <body>

          <xsl:for-each select="$processedNodes/node" >

            <xsl:variable name="filename" select="filename"/>

            <div>
            <xsl:element name="a">
              <xsl:attribute name="href">
                <xsl:value-of select="encode-for-uri( $filename)"/>
              </xsl:attribute>
              <xsl:value-of select="$filename"/>
            </xsl:element>
            </div>

           </xsl:for-each>

        </body>
      </html>
    </xsl:result-document>


  </xsl:template>
</xsl:stylesheet>

