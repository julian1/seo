<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"

  exclude-result-prefixes="xsl mcp gco gmd gmx"
>

  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />

  <xsl:template match="mcp:MD_Metadata">


      <xsl:variable name="uuid" select="gmd:fileIdentifier/gco:CharacterString"/>

      <!-- Data identification is a common root and should be factored -->
      <xsl:variable name="waterBodies" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water-bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />

      <xsl:variable name="landMasses" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.land-masses' ]/ancestor::gmd:MD_Keywords/gmd:keyword/gco:CharacterString" />

      <xsl:variable name="parameters" select="gmd:identificationInfo/mcp:MD_DataIdentification/mcp:dataParameters/mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter" />

      <xsl:variable name="title" select="gmd:identificationInfo/mcp:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />

      <xsl:variable name="organisation" select="gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString" />

        uuid :        '<xsl:value-of select="$uuid"/>'
        organisation: '<xsl:value-of select="$organisation"/>'
        water bodies: '<xsl:value-of select="$waterBodies" separator="', '"/>'
        land masses:  '<xsl:value-of select="$landMasses" separator="', '"/>'
        title:        '<xsl:value-of select="$title" />'

        <xsl:for-each select="$parameters" >

          <!-- TODO this should be restricted by code list as well as longName -->
          <xsl:variable name="parameter" select="mcp:parameterName/mcp:DP_Term/mcp:type/mcp:DP_TypeCode[text() = 'longName']/../../mcp:term/gco:CharacterString" />
          <xsl:variable name="platform" select="mcp:platform/mcp:DP_Term/mcp:term/gco:CharacterString" />


          <xsl:variable name="filename">
            <xsl:value-of select='replace($parameter, " ","-")'/>
            <!-- xsl:value-of select="$waterBodies" separator="-"/-->
          </xsl:variable>

          water bodies: '<xsl:value-of select="$waterBodies" separator="', '"/>'
          <!-- xsl:variable name="filename" select='encode-for-uri( )'/ -->
          parameter     '<xsl:value-of select="$parameter" />'
          platform      '<xsl:value-of select="$platform" />'
          filename      '<xsl:value-of select="$filename" />'

          <xsl:result-document method="xml" href="output/{ encode-for-uri( $filename)}.html">
             <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <html>
            <head>
              <xsl:text>&#xa;</xsl:text>
              <!-- Page Meta Title -->
              <title>
                <xsl:value-of select="$parameter" />
                <xsl:text> </xsl:text>
                <xsl:value-of select="$waterBodies" separator=", "/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$landMasses" separator=", "/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$platform" />
                <xsl:text> IMOS Scientific Research Data </xsl:text>
                <xsl:value-of select="$organisation" />
                <xsl:text> Integrated Marine Observing System</xsl:text>
              </title>
              <xsl:text>&#xa;</xsl:text>

              <!-- Page Meta Description -->
              <meta name="description">
                <xsl:attribute name="content">
                  <xsl:value-of select="$parameter"/>
                  <xsl:text> in the </xsl:text>
                  <xsl:value-of select="$waterBodies" separator=", "/>
                  <xsl:text> near </xsl:text>
                  <xsl:value-of select="$landMasses" separator=", "/>
                  <xsl:text> using </xsl:text>
                  <xsl:value-of select="$platform"/>
                  <xsl:text>. The </xsl:text>
                  <xsl:value-of select="$organisation"/>
                </xsl:attribute>
              </meta>


              <xsl:text>&#xa;</xsl:text>
            </head>

            <body>
              <!-- Page Content -->

              <xsl:text>&#xa;</xsl:text>
              <h1>
                <xsl:value-of select="$parameter" />
                <xsl:text> in the </xsl:text>
                <xsl:value-of select="$waterBodies" separator=", "/>
                <xsl:text>.</xsl:text>
              </h1>

              <xsl:text>&#xa;</xsl:text>
              <h2>
                <xsl:text>Scientific Research Data obtained near </xsl:text>
                <xsl:value-of select="$landMasses" separator=", "/>
                <xsl:text>.</xsl:text>
              </h2>

              <xsl:text>&#xa;</xsl:text>
              <p>
                <xsl:text>The </xsl:text>
                <xsl:value-of select="$title" />
                <xsl:text> is collected by a combination of </xsl:text>
                <xsl:value-of select="$platform"/>
                <xsl:text> in the </xsl:text>
                <xsl:value-of select="$waterBodies" separator=", "/>
                <xsl:text> off the coastlines(s) of </xsl:text>
                <xsl:value-of select="$landMasses" separator=", "/>
                <xsl:text> by </xsl:text>
                <xsl:value-of select="$organisation"/>
                <xsl:text>.</xsl:text>
              </p>

              <xsl:text>&#xa;</xsl:text>
              <xsl:text>The </xsl:text>
              <xsl:value-of select="$parameter" />
              <xsl:text> data sets are useful for scientific and/or academic research and are free to download from the IMOS Portal.</xsl:text>

              <!-- avoid xsl generating self-closing p as non valid html -->
              <xsl:text>&#xa;</xsl:text>
              <p>
              </p>
              <h2>
                <xsl:value-of select="$parameter" />
                <xsl:text> Data Collection Map</xsl:text>
              </h2>


              <xsl:text>&#xa;</xsl:text>
              <xsl:element name="img">
                <xsl:attribute name="src">
                  <!-- the browser is responsible for transforming &amp; to & when method is html -->
                  <!-- TODO extract the real extent -->
                  <xsl:value-of select="'http://maps.googleapis.com/maps/api/staticmap?size=300x300&amp;maptype=satellite&amp;path=color%3aorange|weight:3|-28,153|-27,153|-27,156|-28,156|-28,153&amp;path=color%3aorange|weight:3|-10,127|-8,127|-8,128|-10,128|-10,127'" disable-output-escaping="yes" />
                 </xsl:attribute>
              </xsl:element>


              <!-- http://stackoverflow.com/questions/2906582/how-to-create-an-html-button-that-acts-like-a-link -->

              <!-- this form approach doesn't work as the client browser strips the uuid parameter -->
              <!-- xsl:element name="form">
                <xsl:attribute name="action">
                  <xsl:value-of select="concat( 'https://imos.aodn.org.au/imos123/home?uuid=', $uuid)"/>
                </xsl:attribute>
                <xsl:element name="input">
                  <xsl:attribute name="type">submit</xsl:attribute>
                  <xsl:attribute name="value">
                    <xsl:value-of select="$parameter"/>
                  </xsl:attribute>
                </xsl:element>
              </xsl:element -->

              <!-- works but obscures the link -->
              <!-- xsl:element name="button">
                <xsl:attribute name="onclick">
                  <xsl:value-of select="concat( concat( 'location.href=''https://imos.aodn.org.au/imos123/home?uuid=', $uuid), '''')"/>
                </xsl:attribute>
                <xsl:value-of select="$parameter"/>
              </xsl:element -->

              <div>
                <!-- http://stackoverflow.com/questions/710089/how-do-i-make-an-html-link-look-like-a-button -->
                <xsl:element name="a">
                  <xsl:attribute name="href">
                    <xsl:value-of select="concat( 'https://imos.aodn.org.au/imos123/home?uuid=', $uuid)"/>
                  </xsl:attribute>
                  <button type="button">
                    <xsl:value-of select="$parameter"/>
                  </button>
                </xsl:element>
              </div>




            </body>
            </html>
          </xsl:result-document>
        </xsl:for-each>

  </xsl:template>
</xsl:stylesheet>

