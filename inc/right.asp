<%
if instr(session("Limit"),"C1")>0 then 
session.TimeOut=60
if session("admin_name")="" then
response.write "<script language=JavaScript>" & chr(13) & "alert('����δ��¼���߳�ʱ,���¼��');"&"window.location.href = 'admin/index.asp'"&" </script>"
response.end
end if
elseif instr(session("Limit"),"K1")>0 then 
session.TimeOut=60
if session("admin_name")="" then
response.write "<script language=JavaScript>" & chr(13) & "alert('����δ��¼���߳�ʱ,���¼��');"&"window.location.href = 'store/index.asp'"&" </script>"
response.end
end if
elseif instr(session("Limit"),"Y1")>0 then 
session.TimeOut=60
if session("admin_name")="" then
response.write "<script language=JavaScript>" & chr(13) & "alert('����δ��¼���߳�ʱ,���¼��');"&"window.location.href = 'manager/index.asp'"&" </script>"
response.end
end if
end if 

sysConfig="���۹���ϵͳ"


%>