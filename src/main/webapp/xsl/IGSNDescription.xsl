<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" 
 	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
        xmlns="http://schema.igsn.org/description/1.0"
	exclude-result-prefixes="xsl "
>

    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" encoding="UTF-8" />


    <xsl:template match="*">
        <xsl:element name="{local-name()}" namespace="http://schema.igsn.org/description/1.0">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>



<xsl:template match="/*[local-name()='resource']/*[local-name()='supplementalMetadata']">
<xsl:variable name="igsn" select="/*[local-name()='resource']/*[local-name()='identifier']"/>

<supplementalMetadata>
<record>
<xsl:text>http://pmd.gfz-potsdam.de/igsn/retrivedetailed.php?igsn=</xsl:text><xsl:value-of select="$igsn"/>
</record>
</supplementalMetadata>
</xsl:template>

    <xsl:template match="comment() | text() | processing-instruction()">
        <xsl:copy/>
    </xsl:template>
    
    <xsl:template match="@*">
     <xsl:attribute name="{local-name()}" >
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@xsi:schemaLocation">
     <xsl:attribute name="xsi:schemaLocation">
            <xsl:text>http://schema.igsn.org/description/1.0 http://schema.igsn.org/description/1.0/resource.xsd</xsl:text>
        </xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>
