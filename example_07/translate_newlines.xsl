<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" 

  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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


</xsl:stylesheet>
