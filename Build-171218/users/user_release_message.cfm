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
<title>User Release Message</title>
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
        <p style="margin-bottom: 0px;">
<cfset success=0>
<cfset failure=0>

<cfquery name="getmsg" datasource="#datasource#">
select * from msgs where mail_id='#url.mid#' and secret_id='#url.sid#'
</cfquery>

<cfif #getmsg.recordcount# GTE 1>
<cfset quarfile="/mnt/data/amavis/#getmsg.quar_loc#">
<cfif fileExists(quarfile)> 

<cfexecute name = "/usr/sbin/amavisd-release"
timeout = "240"
outputfile ="/dev/null"
arguments="#getmsg.quar_loc# #url.sid#">
</cfexecute>

<cfset success=#success#+1>

<cfelseif NOT fileExists(quarfile)> 
<cfset failure=#failure#+1>
</cfif>

<cfelseif #getmsg.recordcount# LT 1>
<cfset failure=#failure#+1>

</cfif>

<cfoutput>
<cflocation url="loading.cfm?StartRow=1&DisplayRows=15&startdate=&enddate=&starttime=&endtime=&action=Release Msg&s=#success#&f=#failure#&a=Release Msg">
</cfoutput>


&nbsp;</p>
      </td>
    </tr>
  </table>
</body>
</html>
   