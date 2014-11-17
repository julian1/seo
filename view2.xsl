<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gco="http://www.isotc211.org/2005/gco" 
  xmlns:gmd="http://www.isotc211.org/2005/gmd" 
  xmlns:gmx="http://www.isotc211.org/2005/gmx" 
>


  <xsl:template match="mcp:MD_Metadata">

    <!-- xsl:variable name="target"/ --> 

    <html>
    <body>


    <p>TARGET: <xsl:value-of select="$target" /></p>

    <!-- xsl:apply-templates select="//gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]" /-->
    <!-- were going to need commas, which will be nasty -->

    
    <!-- Page Meta Description -->
    ... in the    
    <xsl:for-each select="//gmd:thesaurusName//gmx:Anchor[text() = 'geonetwork.thesaurus.local.theme.water_bodies' ]/ancestor::gmd:MD_Keywords/gmd:keyword" >
      <xsl:value-of select="gco:CharacterString" />,  
    </xsl:for-each> 
    near
    ...

    <xsl:value-of select="//gmd:identificationInfo//gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString" /> scientific research data sets are accessible through the IMOS Portal.



    <!-- Page Conent -->

    <!-- so we loop the parameters or what ?? we need to at least check that it's there we'll loop 
      test if the node exists. 
  
      <xsl:if test="not(/html/body)">body node missing</xsl:if> 
    -->    

   

    <!-- list of all the parameters -->
    <xsl:for-each select="//mcp:DP_DataParameters/mcp:dataParameter/mcp:DP_DataParameter/mcp:parameterName/mcp:DP_Term/mcp:term/gco:CharacterString" > 
      <xsl:variable name="myParameter" select="."/>
    
      param <xsl:value-of select="$myParameter" />,
    </xsl:for-each> 


 

    <h1>  
    </h1> 

    <h2>Scientific Research Data obtained near ... </h2>

    The 
    <xsl:value-of select="//gmd:identificationInfo//gmd:title/gco:CharacterString" />
    is collected


    </body>
    </html>
  </xsl:template>

  <!-- Ok, think we should perhaps be gathering up variables --> 


  <!-- xsl:template match="gmx:Anchor">
    <h2> HERE : <xsl:value-of select="./ancestor::gmd:MD_Keywords" /> </h2>
  </xsl:template -->



</xsl:stylesheet>

