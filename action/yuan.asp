<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<%
if Request("wor")="del" then
id=request("id")
idArr=split(id,",")
for i=0 to ubound(idArr)
sql="update Yuan_Info set is_ok='false' where id="&trim(idArr(i))
conn.execute(sql)
next
end if
%>
<%
action=Request("action")
id=Request("id")
if action="yes" Then
 set rs=server.createobject("adodb.recordset") 
if id="" then
   set rsCheck = conn.execute("select Yname from Yuan_Info where Yname='" & trim(Request.Form("idcard")) & "'")
     if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('�ͻ��ͻ���� " & trim(Request.Form("idcard")) & " �Ѵ��ڣ����飡');history.back(-1);</script>"
      response.end
     end if
   set rsCheck=nothing
   sql="select * from Yuan_Info" 
   rs.open sql,conn,3,3
   rs.addnew
else
   sql="select * from Yuan_Info where id="&id&"" 
   rs.open sql,conn,1,2
end if
rs("Yname")=Request("cname")
rs("Yprice")=Request("idcard")
rs("Ydan")=Request("T1")
 rs.update
 rs.close
set rs=nothing
 Response.Redirect "?action=list"
end if
%>
<html>
<head>
<title>У���ǹ���ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../images/main.css" rel="stylesheet" type="text/css">
<script language=JavaScript type=text/JavaScript>
function CheckAll(form)
{for (var i=0;i<form.elements.length;i++){
var e = form.elements[i];
if (e.name != 'chkall') e.checked = form.chkall.checked;
}
}
</script>
<script language=JavaScript>
<!--
function DoEmpty(params)
{
if (confirm("���Ҫɾ��������¼��ɾ����˼�¼����������ݶ�����ɾ�������޷��ָ���"))
window.location = params ;
}

function check()
{

  if (document.add.cname.value=="")
     {
      alert("����дԭ�����ƣ�")
      document.add.cname.focus()
      document.add.cname.select()
      return
     }
	 
  if (document.add.idcard.value=="")
     {
      alert("�۸�δ�")
      document.add.idcard.focus()
      document.add.idcard.select()
      return
     }
  if (document.add.T1.value=="")
     {
      alert("��λδ�")
      document.add.T1.focus()
      document.add.T1.select()
      return
     }	 
	 	 
     document.add.submit()
}

 function next()
 {
  if(event.keyCode==13)event.keyCode=9;
 }
-->
</script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF">
	<%if action="list" then%><BR>
        <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="yuan.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="6"  class="optiontitle"> ��ӿͻ���Ϣ </td>
        </tr>
        <tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> ���ƣ�</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" onKeyDown="next()" size="20" maxlength="10" > 
            ���س�\TAB������������һѡ��</td>
        </tr>		
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">�۸�</td>
		  <td colspan="5"><input name="idcard" type="text" id="idcard" onKeyDown="next()" value="0" > </td>
		</tr>
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">��λ��</td>
		  <td colspan="5"><input name="T1" type="text" id="T1" onKeyDown="next()" value="-" > </td>
		</tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="6" >
		     <INPUT TYPE="hidden" name="action" value="yes">
            <input type="button" name="Submit" value="�ύ" onClick="check()">
          	<input type="button" name="Submit2" value="����" onClick="history.back(-1)"></td>
        </tr>
		</FORM>
      </table> 
<%end if%>
<br>
<%if action="list" then%>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="5"  class="optiontitle">�ͻ���Ϣ</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
		  <td width="4%">ѡ��</td>
          <td width="24%">ԭ������</td>
          <td width="24%">�ɹ��۸�</td>
		  <td width="24%">������λ</td>
		  <td width="24%">����</td>
        </tr>	
<%
sql="select * from Yuan_Info where is_ok='True' order by id desc"
 set rs=server.createobject("adodb.recordset") 
 rs.open sql,conn,1,1
 if not rs.eof then
 proCount=rs.recordcount
	rs.PageSize=15
     if not IsEmpty(Request("ToPage")) then
	    ToPage=CInt(Request("ToPage"))
		if ToPage>rs.PageCount then
		   rs.AbsolutePage=rs.PageCount
		   intCurPage=rs.PageCount
		elseif ToPage<=0 then
		   rs.AbsolutePage=1
		   intCurPage=1
		else
		   rs.AbsolutePage=ToPage
		   intCurPage=ToPage
		end if
	 else
		rs.AbsolutePage=1
		intCurPage=1
	 end if
	 intCurPage=CInt(intCurPage)
	 For i = 1 to rs.PageSize
	 if rs.eof then     
	 Exit For 
	 end if
%>
       <form name="del" action="" method="post">
        <tr align='center' bgcolor='#FFFFFF' onmouseover='this.style.background="#F2FDFF"' onmouseout='this.style.background="#FFFFFF"'>
          <td><input type="checkbox" name="id" value="<%=rs("id")%>"></td>
          <td><%=rs("Yname")%></td>
		  <td><%=rs("Yprice")%></td>
		  <td><%=rs("Ydan")%></td>
          <td><IMG src="../images/edit.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">�޸�</a> | <IMG src="../images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("id")%>&action=list&ToPage=<%=intCurPage%>')">ɾ��</a></td>
        </tr>
<%
rs.movenext 
next
%>
		<tr bgcolor="#F2FDFF">
		  <td colspan="5">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> ȫѡ
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="ɾ����ѡ" onClick="{if(confirm('ȷ��Ҫɾ����¼��ɾ���󽫱��޷��ָ���')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="5"> �ܹ���<font color="#ff0000"><%=rs.PageCount%></font>ҳ, <font color="#ff0000"><%=proCount%></font>���ͻ���Ϣ, ��ǰҳ��<font color="#ff0000"><%=intCurPage%> </font><%if intCurPage<>1 then%><a href="?action=list">��ҳ</a> | <a href="?action=list&ToPage=<%=intCurPage-1%>">��һҳ</a> | <% end if
if intCurPage<>rs.PageCount then %><a href="?action=list&ToPage=<%=intCurPage+1%>">��һҳ</a> | <a href="?action=list&ToPage=<%=rs.PageCount%>"> ���ҳ</a><% end if%></span></td>
        </tr>
<%
else
%>
        <tr align="center" bgcolor="#ffffff">
          <td colspan="5">�Բ���Ŀǰ���ݿ��л�û����ӿͻ���Ϣ��</td>
        </tr>
<%
rs.close
set rs=nothing
end if
%>
      </table>
<br>
<%end if%>
<%if action="edit" then
set rs=server.createobject("adodb.recordset") 
sql="select * from Yuan_Info where id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
       <form name="add" method="post" action="yuan.asp">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> �ͻ���Ϣ </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> ���ƣ�</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" value="<%=rs("Yname")%>" size="50" maxlength="50" onKeyDown="next()"> 
          ���س�\TAB������������һѡ��</td>
        </tr>		
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">�۸�</td>
		  <td colspan="5" align="left"><input name="idcard" type="text" id="idcard" value="<%=rs("Yprice")%>" onKeyDown="next()"></td>
		</tr><tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">��λ��</td>
		  <td colspan="5" align="left"><input name="T1" type="text" id="T1" value="<%=rs("Ydan")%>" onKeyDown="next()"></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="6">
		  <input type="hidden" name="action" value="yes">
          <input type="button" name="Submit2" value="�ύ" onClick="check()">
          <input type="button" name="Submit2" value="����" onClick="history.back(-1)">
		  <input name="id" type="hidden" id="id" value="<%=rs("id")%>"></td>
		</tr>
  		</FORM>
  	</table>
<%
end if
end if
%>  
<%if action="view" then
set rs=server.createobject("adodb.recordset") 
sql="select * from Yuan_Info where id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> �ͻ���Ϣ </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> ���ƣ�</td>
          <td colspan="5" bgcolor="#FFFFFF"><%=rs("Yname")%></td>
        </tr>		
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">�۸�</td>
		  <td colspan="5" align="left"><%=rs("Yprice")%></td>
		</tr>
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">��λ��</td>
		  <td colspan="5" align="left"><%=rs("Ydan")%></td>
		</tr>
  	</table>
<%
end if
end if
%> 
  
    </td>
  </tr>
</table>
</body>
</html>