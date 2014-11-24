                          <xsl:element name="input">
                  <xsl:attribute name="type">submit</xsl:attribute>
                  <xsl:attribute name="value">Gojkkkkjj
                    <xsl:value-of select="'Go to Google"/>
                   </xsl:attribute>
                </xsl:element>



              <xsl:element name="button">
                <xsl:attribute name="src">
                  <!-- the browser transforms &amp; to & when html -->
                  <xsl:value-of select="'http://www.google.com" disable-output-escaping="yes" />
                 </xsl:attribute>
                <xsl:attribute name="align">left</xsl:attribute>
              </xsl:element>



			<xsl:variable name="waterBodiesList" select="$waterBodies"/>
            <xsl:value-of select="$waterBodies" separator="-"/>
          </xsl:variable>

          <xsl:variable name="filename" select='encode-for-uri( concat( replace($parameter, " ","-"), $waterBodiesList ))'/>

 


        <xsl:for-each select="$parameters" >

          <xsl:result-document method="xml" href="file_{@id}-output.xml">



            param <xsl:value-of select="." />
            <!-- xsl:copy-of select="."/ -->
          </xsl:result-document>

        </xsl:for-each> 



name="parameter" content=" <xsl:value-of select="$target"/>" />

    <p>parameter: <xsl:value-of select="$target" /></p>



    <!-- list of all the parameters -->
    <xsl:for-each select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName/mcp:DP_Term/mcp:term/gco:CharacterString" > 
      <xsl:variable name="myParameter" select="."/>
      param <xsl:value-of select="$myParameter" />,
      <xsl:if test="$myParameter=$target"> *** </xsl:if> 
    </xsl:for-each> 



    parameter exists: <xsl:value-of select="$parameterExists"/>


    <xsl:if test="not($parameterExists)"> *** NOT FOUND *** </xsl:if> 


    <!-- xsl:apply-templates select="//gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]" /-->
    <!-- were going to need commas, which will be nasty -->

 
