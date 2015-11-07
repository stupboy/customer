<!--#include file="../inc/conn.asp"-->
<%
response.expires=-1
q=trim(request.querystring("q"))
'-如果q为空-start
if q="" then 
'-如果q不为空
else
 set rs=server.CreateObject("adodb.recordset")
 sql="select * from GoodsInfo where Gname like '%"&q&"%'"
 rs.open sql,conn,1,1
 if not (rs.eof and rs.bof) then
  for i=0 to 9
   if rs.eof then exit for
   response.Write "【<span id='"&i+1&"span"&"' onclick='return GetSpan(this.id)'>"&rs("Gname")&"</span>】"
   rs.movenext
  next
 end if
 rs.close
 set rs=nothing
'-如果q为空-end
end if 
%>