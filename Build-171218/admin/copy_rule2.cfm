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
<title>Copy Rule2</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="Generator" content="NetObjects (http://netobjects.com)">
<link rel="stylesheet" type="text/css" href="./fusion.css">
<link rel="stylesheet" type="text/css" href="./style.css">
<link rel="stylesheet" type="text/css" href="./site.css">
</head>
<body style="background-color: rgb(255,255,255); background-image: none; margin: 0px;">
  <table border="0" cellspacing="0" cellpadding="0" width="803">
    <tr valign="top" align="left">
      <td width="21" height="37"></td>
      <td width="782"></td>
    </tr>
    <tr valign="top" align="left">
      <td></td>
      <td width="782" id="Text1" class="TextObject">
        <p style="margin-bottom: 0px;"><cfif IsDefined("URL.ID")>
<cfquery name="getfilerule" datasource="#datasource#">
select * from file_rule_components where rule_id='#url.id#' order by priority asc
</cfquery>

<cfif #getfilerule.system# is "1">
<cflocation url="error.cfm">

<cfelseif #getfilerule.system# is not "1">

<cfif #getfilerule.recordcount# GTE 1>
<cfquery name="clear" datasource="#datasource#">
delete from file_rule_components_temp where action='edit'
</cfquery>

<cfloop query="getfilerule">
<cfquery name="insertrule" datasource="#datasource#">
insert into file_rule_components_temp
(file_id, rule_id, description, type, priority, action, applied)
values
('#file_id#', '#rule_id#', '#description#', '#type#', '#priority#', 'edit', '2')
</cfquery>
</cfloop>
<cflocation url="edit_file_rule.cfm">

<cfelseif #getfilerule.recordcount# LT 1>
<cflocation url="error.cfm">
</cfif>

</cfif>

<cfelseif NOT IsDefined("URL.ID")>
<cflocation url="error.cfm">
</cfif>

&nbsp;</p>
      </td>
    </tr>
  </table>
</body>
</html>
   