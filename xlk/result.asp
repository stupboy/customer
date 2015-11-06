<!--#include file="../inc/conn.asp"-->
<%
'Download:http://www.jb51.net
'-----------------------------------------------------------------
	dim keyword
	keyword=trim(request.Form("keyword"))			'接收ajax发送的参数
	if keyword="" then response.End()
'------------------------------------------------------------------
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from GoodsInfo where Gname like '"&keyword&"%'"
	rs.open sql,conn,1,1
'------------------------------------------------------------------
	'--------如果没有找到的话,返回0
	'--------如果找到的话,返回所有匹配的项目
	if not (rs.eof and rs.bof) then
		response.Write("<ul>")
		for i=0 to 9
			if rs.eof then exit for
			response.Write("<li value="""&i&""" onclick=""form_auto()"" onmouseover=""mo(this.value)"">"&rs("Gname")&"<span>目前共有"&rs("Gname")&"票</span></li></li>")
			rs.movenext
		next
		response.Write("</ul>")
	end if
	rs.close
	set rs=nothing
%>