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

  <!-- Configuration -->
  <xsl:variable name="maxRecords"         select="1000"/> <!-- Useful to limit when testing. Careful, includes register records -->
  <!--xsl:variable name="maxRecords"         select="7"/--> 

  <xsl:variable name="geonetworkBaseUrl"  select="'https://catalogue-123.aodn.org.au'"/>
  <xsl:variable name="portalDataBaseUrl"  select="'https://imos.aodn.org.au/imos123/home'"/>

  <xsl:variable name="imosLogoUrl"        select="'http://static.emii.org.au/images/logo/IMOS-Ocean-Portal-logo.png'"/>
  <xsl:variable name="emiiInfoUrl"        select="'mailto:info@emii.org.au'"/>
  <xsl:variable name="emiiTermsUrl"       select="'http://imos.org.au/imostermsofuse0.html'"/>
  <xsl:variable name="portalUrl"          select="'https://imos.aodn.org.au/imos123'"/>

  <xsl:variable name="gaScript">
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-54091417-1', 'auto');
        ga('require', 'displayfeatures');
        ga('send', 'pageview');
    </script>
  </xsl:variable>



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



  <!-- The record view -->
  <xsl:template name="record-view">
    <xsl:param name="node" as="element()" />
    <xsl:param name="detail" as="document-node()" />

    <!-- put here rather than intermediate model, because it's more formatting -->
    <xsl:variable name="gaTag">
        <xsl:value-of select="$node/uniqueParameters/broader" separator=", "/>     
        <xsl:text> | </xsl:text>
        <xsl:value-of select="$node/title"/>     
    </xsl:variable>

  
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

        <xsl:text>&#xa;</xsl:text>
        <xsl:copy-of select="$detail/gaScript/*"/>

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
              <xsl:attribute name="onclick">ga('send', 'event', 'Landing Page',  'Logo Image', '<xsl:value-of select="$gaTag"/>')</xsl:attribute>
              <img>
                <xsl:attribute name="src"> 
                  <xsl:value-of select="$detail/imosLogoUrl"/> 
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
          
                <xsl:element name="a">
                  <xsl:attribute name="href">
                    <xsl:value-of select="$node/portalDataUrl"/>
                  </xsl:attribute>
                  <xsl:attribute name="onclick">ga('send', 'event', 'Landing Page',  'Map Image', '<xsl:value-of select="$gaTag"/>')</xsl:attribute>

                  <xsl:element name="img">
                    <xsl:attribute name="src">
                      <!-- the browser is responsible for transforming &amp; to & when method is html -->
                      <!-- TODO extract the real extent -->
                      <xsl:value-of select="'https://static.emii.org.au/images/portalImages/portal_imos.jpg'" disable-output-escaping="yes" />
                    </xsl:attribute>
                    <xsl:attribute name="alt">Geographical extent</xsl:attribute>
                  </xsl:element>

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

                  <xsl:attribute name="onclick">ga('send', 'event', 'Landing Page',  'Download Button', '<xsl:value-of select="$gaTag"/>')</xsl:attribute>

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
                      please contact <xsl:element name="a">
                        <xsl:attribute name="href">
                          <xsl:value-of select="$detail/emiiInfoUrl"/>
                        </xsl:attribute>
                        <!-- eg. strip mailto: prefix-->
                        <xsl:value-of select="replace( $detail/emiiInfoUrl, '.*:(.*)', '$1' )"/>
                      </xsl:element>
                  </p>
              </div>
              <div class="col-md-8">
                  <p>Use of this web site and information available from it is subject to our <xsl:element name="a">
                      <xsl:attribute name="href">
                        <xsl:value-of select="$detail/emiiTermsUrl"/>
                      </xsl:attribute>
                      Conditions of use
                    </xsl:element>
                  </p>
                  <p>&#169; 2014 IMOS</p>
              </div>
            </footer>
          </div>
        </div>

      </body>
    </html>
  </xsl:template>


  <!-- The index view -->
  <xsl:template name="index-view">
    <xsl:param name="processedNodes" as="document-node()" />
    <xsl:param name="detail" as="document-node()" />
 
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <html>
      <head>
        <!-- Latest compiled and minified Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="imos.css" />

        <title>List of parameters, The eMarine Information Infrastructure (eMII)</title>
        <meta charset="utf-8"/>
        <meta name="description" content="List of parameters, The eMarine Information Infrastructure (eMII)"/>

        <!-- use xsl:text to prevent xsl from closing tags, which isn't valid html 5 -->

        <xsl:text>&#xa;</xsl:text>
        <style type="text/css" media="screen"><xsl:text> </xsl:text></style>

        <xsl:text>&#xa;</xsl:text>
        <xsl:copy-of select="$detail/gaScript/*"/>

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
                <xsl:value-of select="$detail/portalUrl"/>
              </xsl:attribute>
              <img>
                <xsl:attribute name="src"> 
                  <!-- differs from record view -->
                  <xsl:value-of select="$detail/imosLogoUrl"/> 
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:text>IMOS logo</xsl:text>
                </xsl:attribute>
              </img>
            </a>
          </div>
        </div>

        <div class="container">
          <xsl:for-each select="$processedNodes/node" >

            <xsl:variable name="filename" select="filename"/>
            <div>
              <h3>
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="$filename"/>
                </xsl:attribute>

                <xsl:value-of select="uniqueParameters/broader" separator=", "/>
                <xsl:text> | </xsl:text>
                <xsl:value-of select="title"/>
              </xsl:element>
              </h3>
            </div>

           </xsl:for-each>
        </div>
  
        <!-- this is repeated in record view and should perhaps be factored -->
        <div class="jumbotronFooter voffset5">
          <div class="container">
            <footer class="row">
              <div class="col-md-4">
                  <p>If you've found this information useful, see something wrong, or have a suggestion, please let us
                      know.
                      All feedback is very welcome. For help and information about this site
                      please contact <xsl:element name="a">
                        <xsl:attribute name="href">
                          <xsl:value-of select="$detail/emiiInfoUrl"/>
                        </xsl:attribute>
                        <!-- eg. strip mailto: prefix-->
                        <xsl:value-of select="replace( $detail/emiiInfoUrl, '.*:(.*)', '$1' )"/>
                      </xsl:element>
                  </p>
              </div>
              <div class="col-md-8">
                  <p>Use of this web site and information available from it is subject to our <xsl:element name="a">
                      <xsl:attribute name="href">
                        <xsl:value-of select="$detail/emiiTermsUrl"/>
                      </xsl:attribute>
                      Conditions of use
                    </xsl:element>
                  </p>
                  <p>&#169; 2014 IMOS</p>
              </div>
            </footer>
          </div>
        </div>

      </body>
    </html>

  </xsl:template>


  <!-- Build an intermediate representation from the record used as input for the record view -->
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

    <!-- take the right most element of the land mass separated by | 
      and remove commas
    -->
    <xsl:variable name="waterBodiesTidied">
      <xsl:for-each select="$waterBodies">
          <xsl:element name="water-body">
            <!--xsl:value-of select="replace(., '.*\|(.*)','$1')"/ -->
            <xsl:value-of select="replace( replace(., '.*\|(.*)','$1'), ',', '')"/>
          </xsl:element>
      </xsl:for-each>
    </xsl:variable>

    <!-- take the right most element of the water body separated by | 
      and remove commas
    -->
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
        <xsl:variable name="elt" select="normalize-space( current-grouping-key())"/>
        <xsl:if test="$elt != ''">
          <xsl:element name="platform">
            <xsl:value-of select="$elt"/>
          </xsl:element>
        </xsl:if>
      </xsl:for-each-group>
    </xsl:variable>


    <!-- Group unique broader parameters -->
    <xsl:variable name="uniqueParameters">
      <xsl:for-each-group select="$parameterList" group-by="broader">
        <xsl:variable name="elt" select="normalize-space( current-grouping-key())"/>
        <xsl:if test="$elt != ''">
          <xsl:element name="broader">
            <xsl:value-of select="$elt"/>
          </xsl:element>
        </xsl:if>
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
      <xsl:value-of select="$uniqueParameters/broader" separator=" "/>
      <xsl:text> | </xsl:text>
      <xsl:value-of select="replace( replace( $title, ' - ', ' '), '\(|\)', '')"/>
      <xsl:text>.html</xsl:text>
    </xsl:variable>


    <xsl:variable name="portalDataUrl">
      <xsl:value-of select="$portalDataBaseUrl"/>
      <xsl:value-of select="'?uuid='"/>
      <xsl:value-of select="$uuid"/>
    </xsl:variable>

    <!-- Create actual elements for the vars -->
    <xsl:element name="filename"> 
       <xsl:value-of select="encode-for-uri(replace( normalize-space( $filename), ' ', '-'))"/> 
    </xsl:element>
    <xsl:element name="uuid"> <xsl:value-of select="$uuid"/> </xsl:element>
    <xsl:element name="organisation"> <xsl:value-of select="$organisation"/> </xsl:element>
    <xsl:element name="title"> <xsl:value-of select="$title"/> </xsl:element>
    <xsl:element name="abstract"> <xsl:value-of select="$abstract"/> </xsl:element>
    <xsl:element name="portalDataUrl"> <xsl:value-of select="$portalDataUrl"/> </xsl:element>
    
    <xsl:element name="uniquePlatforms"> <xsl:copy-of select="$uniquePlatforms"/> </xsl:element>
    <xsl:element name="uniqueParameters"> <xsl:copy-of select="$uniqueParameters"/> </xsl:element>
    <xsl:element name="landMassesTidied"> <xsl:copy-of select="$landMassesTidied"/> </xsl:element>
    <xsl:element name="waterBodiesTidied"> <xsl:copy-of select="$waterBodiesTidied"/> </xsl:element>

  </xsl:template>





  <!-- filename generation should be predictable here.
    so apply templates with param.
  -->

  <!-- TODO: we shouldn't have to match on a dummy document -->
  <xsl:template match="/">

    <xsl:variable name="allRecordsRequest" select="concat($geonetworkBaseUrl, '/geonetwork/srv/eng/xml.search.imos?fast=index')"/>
    <!-- cache the node, to guarantee idempotence -->
    <xsl:variable name="nodes" select="document($allRecordsRequest)/response/metadata"/>


    <!-- build intermediate nodes -->
    <xsl:variable name="processedNodes">
      <xsl:for-each select="$nodes" >

        <xsl:variable name="schema" select="geonet:info/schema"/>
        <!-- xsl:value-of select="concat( '&#xa;', $schema, ', ', position(), ', ' )" /-->

        <xsl:if test="$schema = 'iso19139.mcp-2.0' and position() &lt; $maxRecords">

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

    <!-- node with common values --> 
    <xsl:variable name="detail">
      <xsl:element name="imosLogoUrl"> <xsl:value-of select="$imosLogoUrl"/> </xsl:element>
      <xsl:element name="emiiInfoUrl"> <xsl:value-of select="$emiiInfoUrl"/> </xsl:element> 
      <xsl:element name="emiiTermsUrl"> <xsl:value-of select="$emiiTermsUrl"/> </xsl:element>
      <xsl:element name="portalUrl"> <xsl:value-of select="$portalUrl"/> </xsl:element>
      <xsl:element name="gaScript"> <xsl:copy-of select="$gaScript"/> </xsl:element>
    </xsl:variable>


    <!-- record views -->
    <xsl:for-each select="$processedNodes/node" >
      <xsl:variable name="filename" select="filename"/>
      <xsl:result-document method="html" indent="yes" href="output/{ $filename}">
        <xsl:call-template name="record-view">
          <xsl:with-param name="node" select="." />
          <xsl:with-param name="detail" select="$detail" />
          <!-- xsl:with-param name="detail" select="$detail"/ -->
        </xsl:call-template>
      </xsl:result-document>
    </xsl:for-each>


    <!-- index view -->
    <xsl:result-document method="html" indent="yes" href="output/data_collections.html">
      <xsl:call-template name="index-view">
        <xsl:with-param name="processedNodes" select="$processedNodes"/>
        <xsl:with-param name="detail" select="$detail" />
      </xsl:call-template>
    </xsl:result-document>

  </xsl:template>

</xsl:stylesheet>

