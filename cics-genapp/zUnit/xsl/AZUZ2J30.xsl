<?xml version="1.0" encoding="UTF-8"?>

<!--
 ********************************************************************
 * IBM Developer for z Systems
 * IBM z/OS Automated Unit Testing Framework (zUnit)
 * AZUZ2J30
 *
 * This XSL stylesheet can be used to convert a version 3.0.x.x
 * zUnit test runner result file (*.bzures) to a JUnit test run
 * file (*.xml).
 *
 * @since   14.2.1.0
 * @version 14.2.1.0
 ********************************************************************
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xalan="http://xml.apache.org/xslt"
    xmlns:res="http://www.ibm.com/zUnit/3.0.0.0/TestRunner"
    version="1.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"
                standalone="yes" xalan:indent-amount="4"/>

    <xsl:template match="/">
        <xsl:apply-templates select="res:RunnerResult"/>
    </xsl:template>

    <xsl:template match="res:RunnerResult">
        <testsuites>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates select="res:testCase"/>
        </testsuites>
    </xsl:template>

    <xsl:template match="res:testCase">
        <testsuite>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:attribute name="tests">
                <xsl:value-of select="@tests"/>
            </xsl:attribute>
            <xsl:attribute name="errors">
                <xsl:call-template name="res:sum-impl">
                <xsl:with-param name="errors" select="@errors"/>
                <xsl:with-param name="severe" select="@severe"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:attribute name="failures">
                <xsl:value-of select="@warn"/>
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="timestamp">
                <xsl:value-of select="@startTimestamp"/>
            </xsl:attribute>
            <xsl:attribute name="time">
                <xsl:value-of select="@elapsedTime"/>
            </xsl:attribute>
            <xsl:apply-templates select="res:test"/>
            <xsl:if test="res:failure">
                <system-out>
                    <xsl:value-of select="res:failure/@message"/>
                </system-out>
            </xsl:if>
            <xsl:if test="res:error">
                <system-err>
                    <xsl:value-of select="res:error/@message"/>
                </system-err>
            </xsl:if>
        </testsuite>
    </xsl:template>

    <xsl:template name="res:sum-impl">
      <xsl:param name="errors"/>
      <xsl:param name="severe"/>
      <xsl:variable name="result" select="$errors + $severe"/>
      <xsl:value-of select="$result"/>
    </xsl:template>

    <xsl:template match="res:test">
        <testcase>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="classname">
                <xsl:value-of select="../@moduleName"/>
            </xsl:attribute>
            <xsl:attribute name="time">
                <xsl:value-of select="@elapsedTime"/>
            </xsl:attribute>
            <xsl:apply-templates select="res:error"/>
            <xsl:apply-templates select="res:failure"/>
        </testcase>
    </xsl:template>

    <xsl:template match="res:failure">
        <failure>
            <xsl:if test="@message">
                <xsl:text>&#x0a;</xsl:text>
                <xsl:value-of select="@message"/>
            </xsl:if>
            <xsl:text>&#x0a;</xsl:text>
            <xsl:apply-templates select="res:traceback"/>
        </failure>
    </xsl:template>

    <xsl:template match="res:error">
        <error>
            <xsl:if test="@message">
                <xsl:attribute name="message">
                    <xsl:value-of select="@message"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="type">
                <xsl:value-of
    select="concat(@componentCode, @messageNumber, @messageSeverity)"/>
            </xsl:attribute>
            <xsl:if test="@message">
                <xsl:text>&#x0a;</xsl:text>
                <xsl:value-of select="@message"/>
            </xsl:if>
            <xsl:text>&#x0a;</xsl:text>
            <xsl:apply-templates select="res:traceback"/>
        </error>
    </xsl:template>

    <xsl:template match="res:traceback">
        <xsl:if test="@entry">
            <xsl:value-of select="@entry"/>
        </xsl:if>
        <xsl:if test="@entryName">
            <xsl:value-of select="@entryName"/>
        </xsl:if>
        <xsl:if test="@entryName">
            <xsl:value-of select="@programUnitName"/>
        </xsl:if>
        <xsl:if test="@statementID">
            <xsl:text>(</xsl:text>
            <xsl:value-of select="@statementID"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>

</xsl:stylesheet>