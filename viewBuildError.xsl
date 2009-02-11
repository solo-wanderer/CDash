<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
     
   <xsl:include href="header.xsl"/>
   <xsl:include href="footer.xsl"/>
   
   <xsl:include href="local/header.xsl"/>
   <xsl:include href="local/footer.xsl"/> 
      
   <xsl:output method="xml" indent="yes"  doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
   doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
 
    <xsl:template match="/">
      <html>
       <head>
       <title><xsl:value-of select="cdash/title"/></title>
        <meta name="robots" content="noindex,nofollow" />
         <link rel="StyleSheet" type="text/css">
         <xsl:attribute name="href"><xsl:value-of select="cdash/cssfile"/></xsl:attribute>
         </link>
         <xsl:call-template name="headscripts"/> 
       </head>
       <body bgcolor="#ffffff">
   
<xsl:choose>         
<xsl:when test="/cdash/uselocaldirectory=1">
  <xsl:call-template name="header_local"/>
</xsl:when>
<xsl:otherwise>
  <xsl:call-template name="header"/>
</xsl:otherwise>
</xsl:choose>

<br/>

<p><b>Site:</b><xsl:value-of select="cdash/build/site"/></p>
<p><b>Build Name:</b><xsl:value-of select="cdash/build/buildname"/></p>  
 <p><b>Build Time:</b><xsl:value-of select="cdash/build/starttime"/></p>    
Found <xsl:value-of select="count(cdash/errors/error)"/><xsl:text>&#x20;</xsl:text><xsl:value-of select="cdash/errortypename"/>s<br/>
<p><a>
<xsl:attribute name="href">viewBuildError.php?type=<xsl:value-of select="cdash/nonerrortype"/>&#38;buildid=<xsl:value-of select="cdash/build/buildid"/></xsl:attribute>
<xsl:value-of select="cdash/nonerrortypename"/>s</a> are here.</p>

<xsl:for-each select="cdash/errors/error">
<br/>

<table width="100%">

<xsl:if test="logline">
<h3><a>Build Log line <xsl:value-of select="logline"/></a></h3>
</xsl:if>

<xsl:if test="sourceline>0">
  <br/>
  File: <b><xsl:value-of select="sourcefile"/></b>
  Line: <b><xsl:value-of select="sourceline"/></b><xsl:text>&#x20;</xsl:text>
  <a>
 <xsl:attribute name="href">
  <xsl:value-of select="cvsurl"/>
 </xsl:attribute>
 CVS/SVN</a>
</xsl:if>

<xsl:if test="precontext">
<tr>
<th class="measurement"><nobr> Pre-Context </nobr></th>
<td>
<pre><xsl:value-of select="precontext"/></pre>
<!--
<textarea readonly="readonly" name="prectx" wrap="off" style="width: 100%" rows="3">
<xsl:value-of select="precontext"/>
</textarea>
-->
</td>
</tr>
</xsl:if>

<xsl:if test="text">
<tr>
<th class="measurement"><nobr> Err/W </nobr></th>
<td>
<pre><xsl:value-of select="text"/></pre>
</td>
</tr>
</xsl:if>

<xsl:if test="postcontext">
<tr>
<th class="measurement"><nobr> Post </nobr></th>
<td>
<pre><xsl:value-of select="postcontext"/></pre>
</td>
</tr>
</xsl:if>

<xsl:if test="targetname">
<tr colspan="2">
<th colspan="2" style="width: 100%; background-color: #b0c4de; font-weight: bold">
  <xsl:value-of select="/cdash/errortypename"/> while building
  <code><xsl:value-of select="language"/></code>
  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
  <xsl:value-of select="outputtype"/>
  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
  "<code><xsl:value-of select="outputfile"/></code>"
  in target <code><xsl:value-of select="targetname"/></code>.
</th>
</tr>
</xsl:if>

<xsl:if test="string-length(sourcefile)>0">
<tr>
<th class="measurement"><nobr>Source File</nobr></th><td><xsl:value-of select="sourcefile"/></td>
</tr>
</xsl:if>

<xsl:if test="argument">
<tr>
<th class="measurement" style="width: 1%">Command</th>
<td>
<div style="margin-left: 25px; text-indent: -25px;">
<xsl:for-each select="argument">
<nobr>"<font class="argument"><xsl:value-of select="."/></font>"</nobr><xsl:text disable-output-escaping="yes"> </xsl:text>
</xsl:for-each>
</div>
</td>
</tr>
</xsl:if>

<xsl:if test="workingdirectory">
<tr>
<th class="measurement" style="width: 1%">Directory</th><td><xsl:value-of select="workingdirectory"/></td>
</tr>
</xsl:if>

<xsl:if test="exitcondition">
<tr>
<th class="measurement"><nobr>Exit Condition</nobr></th><td><xsl:value-of select="exitcondition"/></td>
</tr>
</xsl:if>

<xsl:if test="stdoutput">
<tr>
<th class="measurement"><nobr> Standard Output </nobr></th>
<td>
<textarea readonly="readonly" name="stdout" wrap="off" style="width: 100%">
  <xsl:attribute name="rows"><xsl:value-of select="stdoutputrows"/></xsl:attribute>
<xsl:value-of select="stdoutput"/>
</textarea>
</td>
</tr>
</xsl:if>

<xsl:if test="stderror">
<tr>
<th class="measurement"><nobr>Standard Error</nobr></th>
<td>
<textarea readonly="readonly" name="stderr" wrap="off" style="width: 100%">
  <xsl:attribute name="rows"><xsl:value-of select="stderrorrows"/></xsl:attribute>
<xsl:value-of select="stderror"/>
</textarea>
</td>
</tr>
</xsl:if>

</table>
</xsl:for-each>
<br/>
<!-- FOOTER -->
<br/>
<xsl:choose>         
<xsl:when test="/cdash/uselocaldirectory=1">
  <xsl:call-template name="footer_local"/>
</xsl:when>
<xsl:otherwise>
  <xsl:call-template name="footer"/>
</xsl:otherwise>
</xsl:choose>
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
