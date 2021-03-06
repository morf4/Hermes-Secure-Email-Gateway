<!--
Hermes Secure Email Gateway Copyright Dionyssios Edwards 2011-2017. All Rights Reserved.

This file is part of Hermes Secure Email Gateway Community Edition.

    Hermes Secure Email Gateway Community Edition is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Hermes Secure Email Gateway Community Edition is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with Hermes Secure Email Gateway Community Edition.  If not, see <https://www.gnu.org/licenses/agpl.html>.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Download Pfx</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="Generator" content="NetObjects (http://netobjects.com)">
<link rel="stylesheet" type="text/css" href="./fusion.css">
<link rel="stylesheet" type="text/css" href="./style.css">
<link rel="stylesheet" type="text/css" href="./site.css">
</head>
<body style="background-color: rgb(255,255,255); background-image: none; margin: 0px;">
  <table border="0" cellspacing="0" cellpadding="0" width="867">
    <tr valign="top" align="left">
      <td width="47" height="57"></td>
      <td width="820"></td>
    </tr>
    <tr valign="top" align="left">
      <td></td>
      <td width="820" id="Text378" class="TextObject">
        <p style="margin-bottom: 0px;"><cfset certid = "#url.id#">

<cfquery name="getcertdetails" datasource="#datasource#">
select * from recipient_certificates where id = <cfqueryparam value = #certid# CFSQLType = "CF_SQL_INTEGER">
</cfquery>

<cfif #getcertdetails.external_ca# is "1">
<cfset pfxfile="/opt/hermes/HermesExternalCACerts/#getcertdetails.pfx_certificate_name#">
<cfelse>
<cfquery name="getca" datasource="#datasource#">
select * from ca_settings where id='#getcertdetails.ca_id#'
</cfquery>
<cfset pfxfile="/opt/hermes/CA/#getca.ca_directory#/root_ca/PFX/#getcertdetails.pfx_certificate_name#">
</cfif>

<cfif NOT fileExists(pfxfile)> 
<cfoutput>

<cflocation url="view_smime_certificates.cfm?id=#getcertdetails.user_id#&type=#type#&action=certnoexist&StartRow=#StartRow#&DisplayRows=#DisplayRows#&filter=#filter#&show=#show#">
</cfoutput>

<cfelseif fileExists(pfxfile)>

<cffile action = "copy" source = "#pfxfile#" destination = "/opt/hermes/tmp/#getcertdetails.pfx_certificate_name#">

<cfoutput>
<cfheader name="Content-disposition" value="attachment;filename=#getcertdetails.pfx_certificate_name#">
<CFCONTENT FILE="/opt/hermes/tmp/#getcertdetails.pfx_certificate_name#" type="application/unknown" DELETEFILE="Yes">
</cfoutput>



</cfif>


&nbsp;</p>
      </td>
    </tr>
  </table>
</body>
</html>
   