<%
'session.timeout=6000-
'Server.ScriptTimeOut=2000-

'dim conn,rs,sysConfig,db-
'db="/data/Xiao5u.mdb" '数据库文件位置-
'set conn=server.createobject("adodb.connection")-
'conn.open "driver={Microsoft Access Driver (*.mdb)};pwd=xiao5u;dbq=" &Server.MapPath(""&db&"")-

'Set rs = Server.CreateObject("ADODB.Recordset")-
'数据库连接文件-
set conn=server.CreateObject("adodb.connection")
'“.”为服务器地址、ST为连接数据库名称、sa为数据库用户名、PWD为数据库密码-
ConnStr="server=113.10.138.110;driver={sql server};database=cha;uid=sa;pwd=!@#$%asdfg"
conn.Open connstr
'如果连接出错则报错-
If Err Then
  err.Clear
  Set Conn = Nothing
  Response.Write "数据库连接出错，请检查Conn.asp文件中的数据库参数设置。"
  response.Write connstr
  Response.End
End If
'自定义函数关闭数据库连接-
sub CloseConn()
 On Error Resume Next
 If IsObject(Conn) Then
  conn.close
  set conn=nothing
 end if
end Sub

%>
