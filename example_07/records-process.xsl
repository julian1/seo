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

  <!-- change name geonetworkBaseUrl? -->
  <xsl:variable name="geonetworkBaseUrl" select="'https://catalogue-123.aodn.org.au'"/>
  <xsl:variable name="portalDataBaseUrl" select="'https://imos.aodn.org.au/imos123/home'"/>

  <!-- want this to be available to the index for styling etc -->
  <xsl:variable name="portalLogoUrl" select="'http://static.emii.org.au/images/logo/IMOS-Ocean-Portal-logo.png'"/>



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




  <xsl:template name="record-view">
    <xsl:param name="node" as="element()" />
  
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <html>
      <head>
    
        <!-- Latest compiled and minified Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="imos.css" />

        <!-- Page Meta Title -->
        <title>
          <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
          <xsl:text> | Seas Oceans Atmosphere | </xsl:text>
          <xsl:value-of select="$node/uniquePlatforms/platform" separator=", "/>
          <xsl:text> | IMOS Scientific Research Data </xsl:text>
          <xsl:value-of select="$node/organisation" />
          <xsl:text> | Integrated Marine Observing System</xsl:text>
        </title>

        <meta charset="utf-8"/>

        <!-- Page Meta Description -->
        <meta name="description">
          <xsl:attribute name="content">

            <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
            <xsl:text> in the oceans, seas and/or atmosphere near </xsl:text>
            <xsl:value-of select="$node/landMassesTidied/land-mass" separator=", "/>
            <xsl:text> using </xsl:text>
            <xsl:value-of select="$node/uniquePlatforms/platform" separator=", "/>
            <xsl:text>. </xsl:text>

            <xsl:text>The </xsl:text>
            <xsl:value-of select="$node/organisation"/>
            <xsl:text> scientific research data sets are accessible through the IMOS Portal.</xsl:text>

          </xsl:attribute>
        </meta>

        <!-- use xsl:text to prevent xsl from closing tags, which isn't valid html 5 -->
        <style type="text/css" media="screen"><xsl:text> </xsl:text></style>

      </head>

      <body>

        <div class="imosHeader">
          <div class="container">
            <a>  
              <xsl:attribute name="class">
                <xsl:text>btn</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="role">
                <xsl:text>button</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="href">
                <xsl:value-of select="$node/portalDataUrl"/>
              </xsl:attribute>

              <img>
                <xsl:attribute name="src"> 
                  <xsl:value-of select="$node/portalLogoUrl"/> 
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:text>IMOS logo</xsl:text>
                </xsl:attribute>
              </img>
            </a>

          </div>
        </div>

        <div class="container">
          <header>
            <!-- Page Content -->
            <h1>
              <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
              <xsl:text> | Oceans Seas Atmosphere</xsl:text>
            </h1>
    
            <h2>
              <xsl:value-of select="$node/waterBodiesTidied/water-body" separator=", "/>
            </h2>

            <!-- TODO: should the header end here? -->
            <h3>
              <xsl:text> Scientific Research Measurement Data recorded off the coast(s) of </xsl:text>
              <xsl:value-of select="$node/landMassesTidied/land-mass" separator=", "/>
              <xsl:text>. </xsl:text>
            </h3>

            <p>
              <xsl:value-of select="$node/title" />
              <xsl:text>. This data is collected by a combination of </xsl:text>
              <xsl:value-of select="$node/uniquePlatforms/platform" separator=", "/>
              <xsl:text> in the </xsl:text>
              <xsl:value-of select="$node/waterBodiesTidied/water-body" separator=", "/>
              <xsl:text> off the coastlines(s) by </xsl:text>
              <xsl:value-of select="$node/organisation"/>
              <xsl:text>.</xsl:text>
            </p>
          </header>

          <div>
            <xsl:text>The </xsl:text>
            <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
            <xsl:text> data sets are useful for scientific and/or academic research and are free to download from the IMOS Portal.</xsl:text>
          </div>


          <div class="row">
            <div class="col-md-4">

              <h2>
                <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
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
            </div> <!-- col -->

            <div class="col-md-8">
   
              <div>
                <xsl:element name="a">

                  <xsl:attribute name="href">
                    <xsl:value-of select="$node/portalDataUrl"/>
                  </xsl:attribute>
                  <xsl:attribute name="class">btn btn-primary voffset4</xsl:attribute>
                  <xsl:attribute name="role">button</xsl:attribute>

                  <xsl:value-of select="'Download a '"/>
                  <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
                  <xsl:value-of select="' Data Set'"/>
                </xsl:element>
              </div>

              <h2>
                <xsl:value-of select="string-join(('About the ', $node/title, ' Data Set'), '')"/>
              </h2>

              <p>
                <xsl:call-template name="replace">
                  <xsl:with-param name="string" select="$node/abstract"/>
                </xsl:call-template>
              </p>
            </div> <!-- col -->

          </div> <!-- row -->

        </div> <!-- container -->

        <div class="jumbotronFooter voffset5">
          <div class="container">
            <footer class="row">
              <div class="col-md-4">
                  <p>If you've found this information useful, see something wrong, or have a suggestion, please let us
                      know.
                      All feedback is very welcome. For help and information about this site
                      please contact <a href="mailto:info@emii.org.au">info@emii.org.au</a>
                  </p>
              </div>
              <div class="col-md-8">
                  <p>Use of this web site and information available from it is subject to our
                      <a href="http://imos.org.au/imostermsofuse0.html">Conditions of use</a>
                  </p>
                  <p>&#169; 2014 IMOS</p>
              </div>
            </footer>
          </div>
        </div>

      </body>
    </html>
  </xsl:template>


  <xsl:template name="index-view">
    <xsl:param name="processedNodes" as="document-node()" />
 
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

        <xsl:variable name="request" select="string-join(($geonetworkBaseUrl, '/geonetwork/srv/en/xml.search.keywordlink?request=broader&amp;thesaurus=', $thesaurus, '&amp;id=', $term ),'')" />

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

    <!-- other static content -->

    <!-- a   href="https://imos.aodn.org.au/imos123/home?uuid=4402cb50-e20a-44ee-93e6-4728259250d2"><img src="http://static.emii.org.au/images/logo/IMOS-Ocean-Portal-logo.png" alt="IMOS logo"/ -->

    <xsl:variable name="portalDataUrl">
      <xsl:value-of select="$portalDataBaseUrl"/>
      <xsl:value-of select="'?uuid='"/>
      <xsl:value-of select="$uuid"/>
    </xsl:variable>



    <!-- 
            <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
            <xsl:value-of select="$node/uniquePlatforms/platform" separator=", "/>
            <xsl:value-of select="$node/organisation" />
              <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
              <xsl:value-of select="$node/landMassesTidied/land-mass" separator=", "/>
              <xsl:value-of select="$node/uniquePlatforms/platform" separator=", "/>
              <xsl:value-of select="$node/organisation"/>
              <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
              <xsl:value-of select="$node/waterBodiesTidied/water-body" separator=", "/>
              <xsl:value-of select="$node/landMassesTidied/land-mass" separator=", "/>
              <xsl:value-of select="$node/title" />
              <xsl:value-of select="$node/uniquePlatforms/platform" separator=", "/>
              <xsl:value-of select="$node/waterBodiesTidied/water-body" separator=", "/>
              <xsl:value-of select="$node/organisation"/>
            <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
                <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
                    <xsl:value-of select="concat('https://imos.aodn.org.au/imos123/home?uuid=', $node/uuid)"/>
                  <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>
                <xsl:value-of select="string-join(('About the ', $node/title, ' Data Set'), '')"/>
                  <xsl:with-param name="string" select="$node/abstract"/>
  -->


    <!-- now create actual elements representing vars -->
    <xsl:element name="filename"> <xsl:value-of select="replace( $filename, ' ', '-')" separator="-"/> </xsl:element>
    <xsl:element name="uuid"> <xsl:value-of select="$uuid"/> </xsl:element>
    <xsl:element name="organisation"> <xsl:value-of select="$organisation"/> </xsl:element>
    <xsl:element name="title"> <xsl:value-of select="$title"/> </xsl:element>
    <xsl:element name="abstract"> <xsl:value-of select="$abstract"/> </xsl:element>
    <xsl:element name="portalDataUrl"> <xsl:value-of select="$portalDataUrl"/> </xsl:element>
    
    <xsl:element name="portalLogoUrl"> <xsl:value-of select="$portalLogoUrl"/> </xsl:element>

    <xsl:element name="uniquePlatforms"> <xsl:copy-of select="$uniquePlatforms"/> </xsl:element>
    <xsl:element name="uniqueParameters"> <xsl:copy-of select="$uniqueParameters"/> </xsl:element>
    <xsl:element name="landMassesTidied"> <xsl:copy-of select="$landMassesTidied"/> </xsl:element>
    <xsl:element name="waterBodiesTidied"> <xsl:copy-of select="$waterBodiesTidied"/> </xsl:element>

  </xsl:template>





  <!-- xsl:include href="record-view.xsl" / -->

  <xsl:variable name="request" select="concat($geonetworkBaseUrl, '/geonetwork/srv/eng/xml.search.imos?fast=index')"/>
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
        <!-- xsl:value-of select="concat( '&#xa;', $schema, ', ', position(), ', ' )" /-->

        <xsl:if test="$schema = 'iso19139.mcp-2.0' and position() &lt; 10">

          <xsl:variable name="uuid" select="geonet:info/uuid"/>
          <xsl:variable name="recordRequest" select="concat($geonetworkBaseUrl, '/geonetwork/srv/eng/xml.metadata.get?uuid=', $uuid)" />
          <!-- xsl:value-of select="concat( $uuid, ', ', position(), ', ', $recordRequest )" /-->

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
    <!-- 
    <xsl:for-each select="$processedNodes/node" >
      <xsl:text>&#xa;</xsl:text>
      <xsl:value-of select="filename"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="uuid"/>
    </xsl:for-each>

    -->


    <!-- record views -->
    <xsl:for-each select="$processedNodes/node" >
      <xsl:variable name="filename" select="filename"/>
      <xsl:result-document method="html" indent="yes" href="output/{ encode-for-uri( $filename)}">
        <xsl:call-template name="record-view">
          <xsl:with-param name="node" select="." />
        </xsl:call-template>
      </xsl:result-document>
    </xsl:for-each>


    <!-- index view -->
    <xsl:result-document method="html" indent="yes" href="output/index.html">
      <xsl:call-template name="index-view">
        <xsl:with-param name="processedNodes" select="$processedNodes"/>
      </xsl:call-template>
    </xsl:result-document>

  
  </xsl:template>
</xsl:stylesheet>

