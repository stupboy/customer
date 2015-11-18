<%
if instr(session("Limit"),"C1")>0 then 
session.TimeOut=60
if session("admin_name")="" then
response.write "<script language=JavaScript>" & chr(13) & "alert('您还未登录或者超时,请登录！');"&"window.location.href = 'admin/index.asp'"&" </script>"
response.end
end if
elseif instr(session("Limit"),"K1")>0 then 
session.TimeOut=60
if session("admin_name")="" then
response.write "<script language=JavaScript>" & chr(13) & "alert('您还未登录或者超时,请登录！');"&"window.location.href = 'store/index.asp'"&" </script>"
response.end
end if
elseif instr(session("Limit"),"Y1")>0 then 
session.TimeOut=60
if session("admin_name")="" then
response.write "<script language=JavaScript>" & chr(13) & "alert('您还未登录或者超时,请登录！');"&"window.location.href = 'manager/index.asp'"&" </script>"
response.end
end if
end if 

sysConfig="销售管理系统"


%>