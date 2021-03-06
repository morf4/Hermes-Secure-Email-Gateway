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
<title>User Download Message</title>
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
        <p style="margin-bottom: 0px;"><cfset mailid = "#url.mid#">

<cfquery name="checkq" datasource="#datasource#">
select archive, quar_loc from msgs where mail_id='#mailid#'
</cfquery>

<cfif #checkq.archive# is "N">
<cfset quarfile="/mnt/data/amavis/#checkq.quar_loc#">
<cfelseif #checkq.archive# is "Y">
<cfquery name="getarchive" datasource="#datasource#">
select * from archive_jobs limit 1
</cfquery>

<cfif #getarchive.recordcount# GTE 1>
<cfset quarfile="/mnt/hermesemail_archive/mnt/data/amavis/#checkq.quar_loc#">
<cfelseif #getarchive.recordcount# LT 1>
<cflocation
 url="loading.cfm?StartRow=#url.StartRow#&DisplayRows=#url.DisplayRows#&startdate=#url.startdate#&enddate=#url.enddate#&starttime=#url.
starttime#&endtime=#url.endtime#&action=#action#&m3=5">
</cfif>
</cfif>

<cfif NOT fileExists(quarfile)> 
<cfif #checkq.archive# is "N">

<cflocation
 url="loading.cfm?StartRow=#url.StartRow#&DisplayRows=#url.DisplayRows#&startdate=#url.startdate#&enddate=#url.enddate#&starttime=#url.
starttime#&endtime=#url.endtime#&action=#action#&m3=4">

<cfelseif #checkq.archive# is "Y">
<cflocation
 url="loading.cfm?StartRow=#url.StartRow#&DisplayRows=#url.DisplayRows#&startdate=#url.startdate#&enddate=#url.enddate#&starttime=#url.
starttime#&endtime=#url.endtime#&action=#action#&m3=5">
</cfif>

<cfelseif fileExists(quarfile)>

<cffile action = "copy" source = "#quarfile#" destination = "/var/www/hermes/tmp/eml_#mailid#.eml">

<cfoutput>
<cfheader name="Content-disposition" value="attachment;filename=eml_#mailid#.eml">
<CFCONTENT FILE="/var/www/hermes/tmp/eml_#mailid#.eml" type="application/unknown" DELETEFILE="Yes">
</cfoutput>



</cfif>


&nbsp;</p>
      </td>
    </tr>
  </table>
</body>
</html>
   