<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"

  exclude-result-prefixes="xsl mcp gco gmd gmx"
>

  <!-- Translate newlines to HTML BR Tags
  http://stackoverflow.org/wiki/Translate_newlines_to_HTML_BR_Tags
  -->
  <xsl:template name="replace">
      <xsl:param name="string"/>
      <xsl:choose>
          <xsl:when test="contains($string,'&#10;')">
              <xsl:value-of select="substring-before($string,'&#10;')"/>
              <br/>
              <xsl:call-template name="replace">
                  <xsl:with-param name="string" select="substring-after($string,'&#10;')"/>
              </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
              <xsl:value-of select="$string"/>
          </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />

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

    <xsl:variable name="geonetworkUrl" select="'http://10.11.12.13'"/>
    <xsl:variable name="thesaurus" select="'external.theme.parameterClassificationScheme'"/>


    <!-- Construct an intermediate node with common values in one place --> 
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


    <!-- group unique platforms -->
    <xsl:variable name="platformList">
      <xsl:for-each-group select="$parameterList" group-by="platform">

        <xsl:element name="platform">
        <xsl:value-of select="current-grouping-key()"/>

        </xsl:element>

      </xsl:for-each-group>
    </xsl:variable>


    <xsl:text>&#xa;------broader------&#xa;</xsl:text> 
    <xsl:value-of select="$parameterList/broader" separator=", "/>

    <xsl:text>&#xa;------longName------&#xa;</xsl:text> 
    <xsl:value-of select="$parameterList/longName" separator=", "/>

    <xsl:text>&#xa;------platform------&#xa;</xsl:text> 
    <xsl:value-of select="$parameterList/platform" separator=", "/>

    <xsl:text>&#xa;------first platform------&#xa;</xsl:text> 
    <xsl:value-of select="$parameterList/platform[1]" />


    <xsl:text>&#xa;------ platformList ------&#xa;</xsl:text> 


    <xsl:value-of select="$platformList/platform" separator=", "/>

    <!-- xsl:for-each-group select="$parameterList" group-by="platform">
      <xsl:value-of select="current-grouping-key()"/>
    </xsl:for-each-group-->


    <xsl:text>&#xa;</xsl:text> 


    <!-- doctype -->
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <html>
      <head>
        <!-- Page Meta Title -->
        <title>
          <xsl:value-of select="$parameterList/broader" separator=", "/>
          <xsl:text> | Seas Oceans Atmosphere | </xsl:text>
          <!-- take the first platform -->
          <xsl:value-of select="$parameterList/platform[1]" />
          <xsl:text> | IMOS Scientific Research Data </xsl:text>
          <xsl:value-of select="$organisation" />
          <xsl:text> | Integrated Marine Observing System</xsl:text>
        </title>

        <meta charset="utf-8"/>

        <!-- Page Meta Description -->
        <meta name="description">
          <xsl:attribute name="content">

            <xsl:value-of select="$parameterList/broader" separator=", "/>
            <xsl:text> in the oceans, seas and/or atmosphere near </xsl:text>
            <xsl:value-of select="$landMasses" separator=", "/>

            <xsl:text> using </xsl:text>
            <xsl:text>. The </xsl:text>
            <xsl:value-of select="$organisation"/>
          </xsl:attribute>
        </meta>



      </head>
    </html>




    <xsl:for-each select="$parameters" >
    
      <!-- TODO this should be restricted by code list as well as longName -->
      <xsl:variable name="parameter" select="mcp:parameterName/mcp:DP_Term/mcp:type/mcp:DP_TypeCode[text() = 'longName']/../../mcp:term/gco:CharacterString" />
      <xsl:variable name="platform" select="mcp:platform/mcp:DP_Term/mcp:term/gco:CharacterString" />

    <xsl:for-each select="$waterBodies" >

      <xsl:variable name="waterBody" select="." />


      <xsl:variable name="filename">
        <xsl:value-of select='replace($parameter, " ","-")'/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select='replace($waterBody, " ","-")'/>
        <xsl:text>.html</xsl:text>
      </xsl:variable>

      <!--
      water bodies: '<xsl:value-of select="$waterBodies" separator="', '"/>'
      parameter     '<xsl:value-of select="$parameter" />'
      platform      '<xsl:value-of select="$platform" />'
      filename      '<xsl:value-of select="$filename" />'
      -->

      <xsl:result-document method="xml" href="output/{ encode-for-uri( $filename)}">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <html>
        <head>
          <!-- Page Meta Title -->
          <title>
            <xsl:value-of select="$parameter"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$waterBody"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="$landMasses" separator=", "/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$platform" />
            <xsl:text> IMOS Scientific Research Data </xsl:text>
            <xsl:value-of select="$organisation" />
            <xsl:text> Integrated Marine Observing System</xsl:text>
          </title>

          <meta charset="utf-8"/>

          <!-- Page Meta Description -->
          <meta name="description">
            <xsl:attribute name="content">
              <xsl:value-of select="$parameter"/>
              <xsl:text> in the </xsl:text>
              <xsl:value-of select="$waterBody"/>
              <xsl:text> near </xsl:text>
              <xsl:value-of select="$landMasses" separator=", "/>
              <xsl:text> using </xsl:text>
              <xsl:value-of select="$platform"/>
              <xsl:text>. The </xsl:text>
              <xsl:value-of select="$organisation"/>
            </xsl:attribute>
          </meta>

          <style type="text/css" media="screen">
            .button-link {
              padding: 10px 15px;
              background: #4479BA;
              color: #FFF;
              border-radius: 4px;
            }
          </style>

        </head>

        <body>
          <header>
            <!-- Page Content -->
            <h1>
              <xsl:value-of select="$parameter" />
              <xsl:text> in the </xsl:text>
              <xsl:value-of select="$waterBody"/>
              <xsl:text>.</xsl:text>
            </h1>

            <h2>
              <xsl:text>Scientific Research Data obtained off the coast(s) of </xsl:text>
              <xsl:value-of select="$landMasses" separator=", "/>
              <xsl:text>.</xsl:text>
            </h2>

            <p>
              <xsl:text>The </xsl:text>
              <xsl:value-of select="$title" />
              <xsl:text> is collected by a combination of </xsl:text>
              <xsl:value-of select="$platform"/>
              <xsl:text> in the </xsl:text>
              <xsl:value-of select="$waterBody"/>
              <xsl:text> off the coastlines(s) by </xsl:text>
              <xsl:value-of select="$organisation"/>
              <xsl:text>.</xsl:text>
            </p>
          </header>

          <xsl:text>The </xsl:text>
          <xsl:value-of select="$parameter" />
          <xsl:text> data sets are useful for scientific and/or academic research and are free to download from the IMOS Portal.</xsl:text>

          <!-- avoid xsl generating self-closing p as non valid html -->
          <h2>
            <xsl:value-of select="$parameter" />
            <xsl:text> Data Collection Map</xsl:text>
          </h2>



          <div>
            <xsl:element name="img">
              <xsl:attribute name="src">
                <!-- the browser is responsible for transforming &amp; to & when method is html -->
                <!-- TODO extract the real extent -->
                <xsl:value-of select="'http://maps.googleapis.com/maps/api/staticmap?size=300x300&amp;maptype=satellite&amp;path=color%3aorange%7Cweight:3%7C-28,153%7C-27,153%7C-27,156%7C-28,156%7C-28,153&amp;path=color%3aorange%7Cweight:3%7C-10,127%7C-8,127%7C-8,128%7C-10,128%7C-10,127'" disable-output-escaping="yes" />
              </xsl:attribute>
              <xsl:attribute name="alt">Geographical extent</xsl:attribute>
            </xsl:element>
          </div>


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

            <!-- Good because doesn't hide the link, http://stackoverflow.com/questions/710089/how-do-i-make-an-html-link-look-like-a-button -->
            <!-- but validator complains - 'The element button must not appear as a descendant of the a element' -->
          <!-- div>
            <xsl:element name="a">
              <xsl:attribute name="href">
                <xsl:value-of select="concat( 'https://imos.aodn.org.au/imos123/home?uuid=', $uuid)"/>
              </xsl:attribute>
              <button type="button">
                <xsl:value-of select="string-join(('Download a ', $parameter, ' Data Set'), '')"/>
              </button>
            </xsl:element>
          </div -->

          <!-- just style as a button -->

          <br/>

          <div>
            <xsl:element name="a">
              <xsl:attribute name="href">
                <xsl:value-of select="concat( 'https://imos.aodn.org.au/imos123/home?uuid=', $uuid)"/>
              </xsl:attribute>
              <xsl:attribute name="class">button-link</xsl:attribute>
              <xsl:value-of select="string-join(('Download a ', $parameter, ' Data Set'), '')"/>
            </xsl:element>
          </div>



          <h2>
            <xsl:value-of select="string-join(('About the ', $title, ' Data Set'), '')"/>
          </h2>

          <p>
            <xsl:call-template name="replace">
              <xsl:with-param name="string" select="$abstract"/>
            </xsl:call-template>
            <!-- xsl:copy-of select="translate( $abstract, ' ', '&lt;br /&gt; <br/>' )"/ -->
          </p>

        </body>
        </html>
      </xsl:result-document>
    </xsl:for-each>
    </xsl:for-each>


    <!-- output an index file -->
    <xsl:result-document method="xml" href="output/index.html">
      <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <html>
        <head>
          <title>List of parameters, The eMarine Information Infrastructure (eMII)</title>
          <meta charset="utf-8"/>
          <meta name="description" content="List of parameters, The eMarine Information Infrastructure (eMII)"/>
        </head>
        <body>
          <ul>
            <xsl:for-each select="$parameters">

              <xsl:variable name="parameter" select="mcp:parameterName/mcp:DP_Term/mcp:type/mcp:DP_TypeCode[text() = 'longName']/../../mcp:term/gco:CharacterString" />

                <xsl:for-each select="$waterBodies" >

                  <xsl:variable name="waterBody" select="." />

                  <xsl:variable name="filename">
                    <xsl:value-of select='replace($parameter, " ","-")'/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select='replace($waterBody, " ","-")'/>
                    <xsl:text>.html</xsl:text>
                  </xsl:variable>

                  <li>
                  <xsl:element name="a">
                    <xsl:attribute name="href">
                      <xsl:value-of select="$filename"/>
                    </xsl:attribute>

                    <!-- xsl:value-of select="string-join(('$parameter', '-in-the-', '$waterBody'), '')"/-->
                    <xsl:value-of select='$filename'/>

                  </xsl:element>
                  </li>
                </xsl:for-each>
            </xsl:for-each>
          </ul>
        </body>
      </html>
    </xsl:result-document>

  </xsl:template>
</xsl:stylesheet>

