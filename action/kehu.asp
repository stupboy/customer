<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<%
if Request("wor")="del" then
id=request("id")
idArr=split(id,",")
for i=0 to ubound(idArr)
sql="update Customer set is_ok='false' where id="&trim(idArr(i))
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
   set rsCheck = conn.execute("select UserName from Customer where UserName='" & trim(Request.Form("idcard")) & "'")
     if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('�ͻ� " & trim(Request.Form("idcard")) & " �Ѵ��ڣ����飡');history.back(-1);</script>"
      response.end
     end if
   set rsCheck=nothing
   sql="select * from Customer" 
   rs.open sql,conn,3,3
   rs.addnew
else
   sql="select * from Customer where id="&id&"" 
   rs.open sql,conn,1,2
end if
rs("RealName")=Request("cname")
rs("UserName")=Request("idcard")
rs("CustomerType")=Request("rank")
rs("address")=Request("address")
rs("Moblie")=Request("pcode")
rs("WeiXin")=Request("owner")
rs("Password")=Request("www")
if id ="" then 
rs("createUser")=Session("RealName")
end if
rs("ModifyUser")=Session("RealName")
rs("ModifyTime")=now() 
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
      alert("����д�ͻ����ƣ�")
      document.add.cname.focus()
      document.add.cname.select()
      return
     }
	 
  if (document.add.idcard.value=="")
     {
      alert("����д�ͻ��˺ţ�")
      document.add.idcard.focus()
      document.add.idcard.select()
      return
     }
	 
  if (document.add.rank.value=="")
     {
      alert("��ѡ��ͻ�����")
      document.add.rank.focus()
      document.add.rank.select()
      return
     }
  if (document.add.pcode.length !==11 )
     {
      alert("�ֻ�������������")
      document.add.rank.focus()
      document.add.rank.select()
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
        <form name="add" method="post" action="kehu.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="6"  class="optiontitle"> ��ӿͻ���Ϣ </td>
        </tr>
        <tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> ������</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" onKeyDown="next()" size="20" maxlength="20" > 
            ���س�\TAB������������һѡ��</td>
        </tr>		
		<tr bgcolor="#FFFFFF">
		  <td width="10%" align="right">�û�����</td>
		  <td colspan="5"><input name="idcard" type="text" id="idcard" onKeyDown="next()" value="" >���룺<input name="www" type="text" id="www" value="" ></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ����</td>
		  <td colspan="5" >
           <select name="rank" id="rank" selfvalue="�ͻ�����">
              <option value="">��ѡ��</option>
              <option value="1">��</option>
              <option value="2">���</option>
              <option value="3">����</option>
              <option value="4">�����</option>
              <option value="5">������</option>
            </select>
		  </td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ��ַ��</td>
		  <td><input name="address" type="text" id="address" onKeyDown="next()" ></td>
		  <td align='right'>�ֻ���</td>
		  <td><input name="pcode" type="text" id="pcode" onKeyDown="next()" maxlength="11"></td>
		  <td align='right'>΢�ţ�</td>
		  <td><input name="owner" type="text" id="owner" onKeyDown="next()"></td>
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
          <td colspan="8"  class="optiontitle">�ͻ���Ϣ</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
		  <td width="50">ѡ��</td>
          <td width="10%">�˺�</td>
          <td width="15%">����</td>
          <td width="10%">���</td>
          <td width="10%">��������</td>
          <td width="15%">���۽��</td>
          <td width="20%">����</td>
          <td>ִ�в���</td>
        </tr>	
<%
sql="select * from Customer where is_ok='True' order by id desc"
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
          <td><%=rs("UserName")%></td>
		  <td><%=rs("RealName")%></td>
          <td><%=rs("CustomerType")%></td>
		  <td><%=rs("Sellqty")%></td>
		  <td><%=rs("Moblie")%></td>
		  <td><%=rs("Address")%></td>
          <td><IMG src="../images/view.gif" align="absmiddle"><a href="?action=view&id=<%=rs("id")%>">�鿴</a> | <IMG src="../images/edit.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">�޸�</a> | <IMG src="../images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("id")%>&action=list&ToPage=<%=intCurPage%>')">ɾ��</a></td>
        </tr>
<%
rs.movenext 
next
%>
		<tr bgcolor="#F2FDFF">
		  <td colspan="8">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> ȫѡ
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="ɾ����ѡ" onClick="{if(confirm('ȷ��Ҫɾ����¼��ɾ���󽫱��޷��ָ���')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="8"> �ܹ���<font color="#ff0000"><%=rs.PageCount%></font>ҳ, <font color="#ff0000"><%=proCount%></font>���ͻ���Ϣ, ��ǰҳ��<font color="#ff0000"><%=intCurPage%> </font><%if intCurPage<>1 then%><a href="?action=list">��ҳ</a> | <a href="?action=list&ToPage=<%=intCurPage-1%>">��һҳ</a> | <% end if
if intCurPage<>rs.PageCount then %><a href="?action=list&ToPage=<%=intCurPage+1%>">��һҳ</a> | <a href="?action=list&ToPage=<%=rs.PageCount%>"> ���ҳ</a><% end if%></span></td>
        </tr>
<%
else
%>
        <tr align="center" bgcolor="#ffffff">
          <td colspan="8">�Բ���Ŀǰ���ݿ��л�û����ӿͻ���Ϣ��</td>
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
sql="select * from Customer where is_ok='True' and id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
       <form name="add" method="post" action="kehu.asp">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> �ͻ���Ϣ </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> ���ƣ�</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" value="<%=rs("RealName")%>" size="20" readonly="readonly" > 
          ���س�\TAB������������һѡ��</td>
        </tr>		
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">�û�����</td>
		  <td colspan="5" align="left"><input name="idcard" type="text" id="idcard" value="<%=rs("UserName")%>" readonly="readonly" >���룺<input name="www" type="password" id="www" value="<%=rs("PassWord")%>" ></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ����</td>
		  <td colspan="5" ><input name="rank" type="text" id="rank" value="<%=rs("CustomerType")%>" onKeyDown="next()"></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ��ַ��</td>
		  <td><input name="address" type="text" id="address" value="<%=rs("address")%>" ></td>
		  <td align='right'>�ֻ���</td>
		  <td><input name="pcode" type="text" id="pcode" value="<%=rs("Moblie")%>" onKeyDown="next()"></td>
		  <td align='right'>΢�ţ�</td>
		  <td><input name="owner" type="text" id="owner" value="<%=rs("WeiXin")%>" onKeyDown="next()"></td>
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
sql="select * from Customer where id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> �ͻ���Ϣ </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> ���ƣ�</td>
          <td colspan="5" bgcolor="#FFFFFF"><%=rs("RealName")%></td>
        </tr>		
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">�˺ţ�</td>
		  <td colspan="5" align="left"><%=rs("UserName")%>,���룺<%=rs("Password")%></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ����</td>
		  <td colspan="5" align="left"><%=rs("CustomerType")%></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ��ַ��</td>
		  <td><%=rs("address")%></td>
		  <td align='right'>�绰��</td>
		  <td><%=rs("mOBLIE")%></td>
		  <td align='right'>΢�ţ�</td>
		  <td><%=rs("wEIXIN")%></td>
		</tr>
		
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ����������</td>
		  <td><%=rs("Sellqty")%></td>
		  <td align='right'>���۽�</td>
		  <td><%=rs("SellMoney")%></td>
		  <td align='right'>�����ˣ�</td>
		  <td><%=rs("CreateUser")%></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF">�������ڣ�</td>
		  <td colspan="5" ><%=rs("CreateTime")%></td>
		</tr>
	    <tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF">�޸��ˣ�</td>
		  <td colspan="5" ><%=rs("CreateTime")%></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF">�޸����ڣ�</td>
		  <td colspan="5" ><%=rs("CreateTime")%></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="6">
          <input type="button" name="Submit2" value="����" onClick="history.back(-1)"></td>
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