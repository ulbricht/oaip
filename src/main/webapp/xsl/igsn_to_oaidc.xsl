<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/">
    
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" encoding="UTF-8" />
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="*[local-name()='sampleNumber']">
        <dc:identifier>
            <xsl:text>http://hdl.handle.net/</xsl:text>
            <xsl:value-of select="."/>
        </dc:identifier>
        <dc:identifier>
            <xsl:choose>
                <xsl:when test="string-length(@identifierType) &gt; 0">
                    <xsl:value-of select="lower-case(@identifierType)"/>
                    <xsl:text>:</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="."/>
        </dc:identifier>
    </xsl:template>
    
    <xsl:template match="*[local-name()='registrant']">
        <xsl:for-each select="*[local-name()='registrantName']">
            <xsl:element name="dc:creator">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
 
    <xsl:template match="*[local-name()='relatedResourceIdentifiers']">
        <xsl:for-each select="*[local-name()='relatedIdentifier']">
            <xsl:element name="dc:relation">
                <xsl:choose>
                    <xsl:when test="string-length(@relatedIdentifierType) &gt; 0">
                        <xsl:value-of select="lower-case(@relatedIdentifierType)"/>
                        <xsl:text>:</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:value-of select="."/>            
            </xsl:element>
        </xsl:for-each>            
    </xsl:template>
    
    
    <xsl:template match="*[local-name()='sample']">
        <xsl:element name="oai_dc:dc">
            <xsl:attribute name="xsi:schemaLocation">http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd</xsl:attribute>        
            <xsl:namespace name="dc">http://purl.org/dc/elements/1.1/</xsl:namespace>
            <xsl:apply-templates select="*[local-name()='registrant']"/>
            <xsl:apply-templates select="*[local-name()='sampleNumber']"/>
            <xsl:apply-templates select="*[local-name()='relatedResourceIdentifiers']"/>
        </xsl:element>
    </xsl:template>    
</xsl:stylesheet>
