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
<title>Download Private</title>
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

<cfquery name="getkeyhex" datasource="#datasource#">
select pgp_key_id from recipient_keystores where id = <cfqueryparam value = #certid# CFSQLType = "CF_SQL_INTEGER">
</cfquery>

<cfif #getkeyhex.recordcount# GTE 1>

<cfquery name="customtrans" datasource="#datasource#" result="getrandom_results">
select random_letter as random from captcha_list_all2 order by RAND() limit 8
</cfquery>

<cfquery name="inserttrans" datasource="#datasource#" result="stResult">
insert into salt
(salt)
values
('<cfoutput query="customtrans">#TRIM(random)#</cfoutput>')
</cfquery>

<cfquery name="gettrans" datasource="#datasource#">
select salt as customtrans2 from salt where id='#stResult.GENERATED_KEY#'
</cfquery>

<cfset customtrans3=#gettrans.customtrans2#>

<cfquery name="deletetrans" datasource="#datasource#">
delete from salt where id='#stResult.GENERATED_KEY#'
</cfquery>

<cffile action="read" file="/opt/hermes/scripts/export_pgp_private_key.sh" variable="temp">

<cffile action = "write"
    file = "/opt/hermes/tmp/#customtrans3#_export_pgp_private_key.sh"
    output = "#REReplace("#temp#","THE_KEY","#getkeyhex.pgp_key_id#","ALL")#" addnewline="no">

<cfexecute name = "/bin/chmod"
arguments="+x /opt/hermes/tmp/#customtrans3#_export_pgp_private_key.sh"
timeout = "60">
</cfexecute>


<cfexecute name = "/opt/hermes/tmp/#customtrans3#_export_pgp_private_key.sh"
timeout = "240"
variable="thekeyid2"
arguments="-inputformat none">
</cfexecute>

<!-- Delete File -->
<cfset FiletoDelete="/opt/hermes/tmp/#customtrans3#_export_pgp_private_key.sh">
<cfif fileExists(FiletoDelete)> 
<cffile action="delete" 
file = "#FiletoDelete#">
</cfif>

<cfset keyfile="/opt/hermes/tmp/#getkeyhex.pgp_key_id#_private.asc">


<cfif NOT fileExists(keyfile)> 
<cfoutput>

<cflocation url="view_pgp_keyrings.cfm?id=#certid#&type=#type#&action=keynoexist&StartRow=#StartRow#&DisplayRows=#DisplayRows#&filter=#filter#&show=#show#" addToken = "no">
</cfoutput>

<cfelseif fileExists(keyfile)>

<cfoutput>
<cfheader name="Content-disposition" value="attachment;filename=#getkeyhex.pgp_key_id#_private.asc">
<CFCONTENT FILE="/opt/hermes/tmp/#getkeyhex.pgp_key_id#_private.asc" type="application/unknown" DELETEFILE="Yes">
</cfoutput>

<!-- /cfif fileExists(keyfile) -->
</cfif>

<cfelseif #getkeyhex.recordcount# LT 1>
<cfoutput>
<cflocation url="view_pgp_keyrings.cfm?id=#certid#&type=#type#&action=keynoexist&StartRow=#StartRow#&DisplayRows=#DisplayRows#&filter=#filter#&show=#show#" addToken = "no">
</cfoutput>
</cfif>





&nbsp;</p>
      </td>
    </tr>
  </table>
</body>
</html>
   