<!--#include file="inc/conn.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="lib/lib.all.asp"-->
<% 
dim verifycode,verifycode2
verifycode=Session("pSN")
verifycode2=UCASE(trim(Request.Form("verifycode")))
if verifycode<>verifycode2 then
response.write"<SCRIPT language=JavaScript>alert('���������֤�벻��ȷ��ע�⣺���ִ�Сд \n \n У���ǿƼ�-Www.Xiao5u.Com-������ʾ');"
response.write"location.href='index.asp'</SCRIPT>"
founderr=true
else
session("pSN")=""
if request("action")="login" then
   Username=trim(request("admin_name"))
   Password=trim(request("admin_pass"))
   LogType=trim(request("LogType"))
end if
If Instr(Username,"or")<>0 or Instr(Password,"or")<>0 or Instr(Username,"and")<>0 or Instr(Password,"and")<>0 Then
   response.write "<br><br><br><br><font size=2><center>û�±���˼Һ�̨��лл��<br>����һ�к���Ը���<br>У����-Www.Xiao5u.Com</font>"
else
set rs=server.createobject("adodb.recordset")
sql="select * from admin where Username='"&replace(Username,"'","''")&"' and Password='"&replace(md5(Password),"'","''")&"' and limitText like '%"&logType&"%' "
rs.open sql,conn,1,3
    if rs.eof then
        response.write"<SCRIPT language=JavaScript>alert('��������û������������󡣷�����������!\n \n У���ǿƼ�-Www.Xiao5u.Com-������ʾ');"
		if LogType="C1" or LogType="" then 
        response.write"location.href='admin/index.asp'</SCRIPT>"
		elseif LogType="K1" then 
		response.write"location.href='store/index.asp'</SCRIPT>"
		elseif LogType="Y1" then 
		response.write"location.href='manager/index.asp'</SCRIPT>"
		end if 
    else
		rs("LastLoginIP")=Request.ServerVariables("REMOTE_ADDR")
		rs("LastLoginTime")=now()
		rs.update
        session("admin_name")=request("admin_name")
		session("RealName")=rs("RealName")
		session("Limit")=rs("LimitText")
		db_log session("RealName"),sql,"����ϵͳ"
        response.redirect "sys.asp"
	end if 
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
end if
%>