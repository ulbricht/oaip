<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:datacite21="http://datacite.org/schema/kernel-2.1"
    xmlns:datacite22="http://datacite.org/schema/kernel-2.2"
    xmlns:datacite23="http://datacite.org/schema/kernel-2.3"
    xmlns:datacite3="http://datacite.org/schema/kernel-3"
    xmlns:datacite4="http://datacite.org/schema/kernel-4"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    exclude-result-prefixes="datacite21 datacite22 datacite23 datacite3 datacite4">
    
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" encoding="UTF-8" />
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="*[local-name()='identifier']">
        <dc:identifier>
            <xsl:text>http://dx.doi.org/</xsl:text>
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
    
    <xsl:template match="*[local-name()='creators']">
        <xsl:for-each select="*[local-name()='creator']">
            <xsl:element name="dc:creator">
                <xsl:value-of select="./*[local-name()='creatorName']"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='titles']">
        <xsl:for-each select="*[local-name()='title']">
            <xsl:element name="dc:title">
                <xsl:if test="@xml:lang">
                	<xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='publisher']">
        <xsl:for-each select=".">
            <xsl:element name="dc:publisher">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='publicationYear']">
        <xsl:element name="dc:date">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[local-name()='subjects']">
        <xsl:for-each select="*[local-name()='subject']">
            <xsl:element name="dc:subject">
            	<xsl:if test="@xml:lang">
            		<xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
            	</xsl:if>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='contributors']">
        <xsl:for-each select="*[local-name()='contributor']">
            <xsl:element name="dc:contributor">
                <xsl:value-of select="./*[local-name()='contributorName']"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='dates']">
        <xsl:for-each select="*[local-name()='date']">
            <xsl:element name="dc:date">
                <xsl:if test="@dateType">
                    <xsl:value-of select="@dateType"/><xsl:text>: </xsl:text>                        
                </xsl:if>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='language']">
        <xsl:element name="dc:language">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[local-name()='resourceType']">
        <xsl:for-each select=".">
            <xsl:if test="normalize-space(@resourceTypeGeneral)">
                <xsl:element name="dc:type">
                    <xsl:value-of select="@resourceTypeGeneral"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="normalize-space(.)">
                <xsl:element name="dc:type">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='alternateIdentifiers']">
        <xsl:for-each select="*[local-name()='alternateIdentifier']">
            <xsl:element name="dc:identifier">
                <xsl:choose>
                    <xsl:when test="string-length(@alternateIdentifierType) &gt; 0">
                        <xsl:value-of select="lower-case(@alternateIdentifierType)"/>
                        <xsl:text>:</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='relatedIdentifiers']">
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
    
    <xsl:template match="*[local-name()='sizes']">
        <xsl:for-each select="*[local-name()='size']">
            <xsl:element name="dc:format">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='formats']">
        <xsl:for-each select="*[local-name()='format']">
            <xsl:element name="dc:format">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='rightsList']">
        <xsl:for-each select="*[local-name()='rights']">
            <xsl:element name="dc:rights">
                <xsl:value-of select="."/>
            </xsl:element>
            <xsl:if test="@rightsURI">
                <xsl:element name="dc:rights">
                    <xsl:value-of select="@rightsURI"/>
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='geoLocations']">
	<xsl:choose>
		<xsl:when test="namespace-uri()='http://datacite.org/schema/kernel-3'">
			<xsl:for-each select="*[local-name()='geoLocation']">
			    <xsl:for-each select="child::node()">
				<xsl:element name="dc:coverage">
				    <xsl:value-of select="string(.)"/>
				</xsl:element>
			    </xsl:for-each>            
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="*[local-name()='geoLocation']">
			    <xsl:for-each select="child::node()">
				<xsl:element name="dc:coverage">
				    <xsl:call-template name="node_to_string">
				        <xsl:with-param name="delimiter" select="' '" />
				    </xsl:call-template>
				</xsl:element>
			    </xsl:for-each>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
    </xsl:template>

    <xsl:template match="*[local-name()='descriptions']">
        <xsl:for-each select="*[local-name()='description']">
            <xsl:if test="normalize-space(@descriptionType)">
                <xsl:element name="dc:description">
                    <xsl:value-of select="@descriptionType"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="normalize-space(.)">
                <xsl:element name="dc:description">
                    <xsl:if test="@xml:lang">
                        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang" /></xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="node_to_string">
        <xsl:param name="delimiter" select="' '"/>                
        <xsl:for-each select="descendant::text()">
            <xsl:value-of select="string( . )"/>
            <xsl:if test="position() != last()">
                <xsl:value-of select="$delimiter" />
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*[local-name()='resource']">
        <xsl:element name="oai_dc:dc">
            <xsl:attribute name="xsi:schemaLocation">http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd</xsl:attribute>        
            <xsl:namespace name="dc">http://purl.org/dc/elements/1.1/</xsl:namespace>
            <xsl:apply-templates select="*[local-name()='titles']"/>
            <xsl:apply-templates select="*[local-name()='creators']"/>
            <xsl:apply-templates select="*[local-name()='publisher']"/>
            <xsl:apply-templates select="*[local-name()='publicationYear']"/>
            <xsl:apply-templates select="*[local-name()='dates']"/>            
            <xsl:apply-templates select="*[local-name()='identifier']"/>
            <xsl:apply-templates select="*[local-name()='alternateIdentifiers']"/>
            <xsl:apply-templates select="*[local-name()='relatedIdentifiers']"/>
            <xsl:apply-templates select="*[local-name()='subjects']"/>
            <xsl:apply-templates select="*[local-name()='descriptions']"/>
            <xsl:apply-templates select="*[local-name()='contributors']"/>
            <xsl:apply-templates select="*[local-name()='language']"/>
            <xsl:apply-templates select="*[local-name()='resourceType']"/>
            <xsl:apply-templates select="*[local-name()='sizes']"/>
            <xsl:apply-templates select="*[local-name()='formats']"/>
            <xsl:apply-templates select="*[local-name()='rightsList']"/>
            <xsl:apply-templates select="*[local-name()='geoLocations']"/>
        </xsl:element>
    </xsl:template>    
</xsl:stylesheet>
