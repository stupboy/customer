<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<script language="javascript" type="text/javascript" src="../date/WdatePicker.js"></script>
<%
id=Request("id")
'-ɾ����¼ is_ok='false'-
if Request("wor")="del" then
 id=request("id")
 idArr=split(id,",")
 for i=0 to ubound(idArr)
  sql="update billInfo set is_ok='false' where id="&trim(idArr(i))
  conn.execute(sql)
 next
elseif Request("wor")="del2" then
 id=request("id")
 idArr=split(id,",")
 for i=0 to ubound(idArr)
  sql="delete from billdetail where id="&trim(idArr(i))
  conn.execute(sql)
 next 
  id=request("danno")
elseif Request("addon")="yes" then 
 sql="insert into billInfo (billno,status,cuser,billway,customer_id,billnote,Gdate,cUSTOMER_ID1) values ('"&Request("billno")&"',0,'"&session("RealName")&"','�µ�','"&Request("rank")&"','"&request("comment")&"','"&request("Gdate")&"','"&Request("rank2")&"')"
 conn.execute(sql)
end if
if Request("tj")="yes" then 
sql="update BillInfo set status=1 where id="&Request("id")
conn.execute(sql)
elseif Request("tj")="shou" then 
sql="update BillInfo set status=3 where id="&Request("id")
conn.execute(sql)
end if 
'-��Ӻ��޸ļ�¼ idΪ����Ϊ��� ����Ϊ�޸�-
'-��ȡ���ݱ���-
action=Request("action")
addon=Request("addon")

'--������Ʒ��Ϣ��¼-
if action="yes" Then
 set rs=server.createobject("adodb.recordset") 
 if id="" then
   set rsCheck = conn.execute("select Gname from GoodsInfo where Gname='" & trim(Request.Form("cname")) & "'")
     if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('��Ʒ��Ʒ��� " & trim(Request.Form("idcard")) & " �Ѵ��ڣ����飡');history.back(-1);</script>"
      response.end
     end if
   set rsCheck=nothing
   sql="select * from GoodsInfo " 
   rs.open sql,conn,3,3
   rs.addnew
 else
   sql="select * from GoodsInfo where id="&id&"" 
   rs.open sql,conn,1,2
 end if
 rs("Gname")=Request("cname")
 rs("Gcat")=Request("address")
 rs("Gcost")=Request("pcode")
 rs("Gsell")=Request("owner")
 if id="" then 
 rs("adduser")=session("admin_name")
 end if 

 rs("Muser")=session("admin_name")
 rs.update
 rs.close
 set rs=nothing
 Response.Redirect "?action=list"
end if
%>
<html>
<head>
<title>��������</title>
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
      alert("����д��Ʒ���ƣ�")
      document.add.cname.focus()
      document.add.cname.select()
      return
     }
	 
  if (document.add.address.value=="")
     {
      alert("����д��Ʒ���")
      document.add.address.focus()
      document.add.address.select()
      return
     }
	 
  if (document.add.pcode.value=="")
     {
      alert("��Ʒ�ɹ��ɱ���")
      document.add.pcode.focus()
      document.add.pcode.select()
      return
     }
  
  if (document.add.owner.value=="")
     {
      alert("��Ʒ���ۼ۸�")
      document.add.owner.focus()
      document.add.owner.select()
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
<!--���Ӷ��� �� �����б�-->
<%if action="list" then%>
        <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="dbill.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="6"  class="optiontitle"> ���������µ� </td>
        </tr>
        <tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#F2FDFF"> ���ţ�</td>
          <td colspan="5" bgcolor="#F2FDFF"><input name="billno" type="text" id="billno" value="<%=danhao("D")%>" size="30" maxlength="50" readonly="readonly" > 
            ���س�\TAB������������һѡ��</td>
        </tr>		
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ҵ��Ա��</td>
		  <td colspan="5" >
<%
 sql="select * from Customer where is_ok='true' and customerType=1 order by CustomerType "
 set rs_kehu=conn.execute(sql)
%>
 <select name="rank" id="rank" selfvalue="�ͻ�����">
 <option value="">��ѡ��</option>
<%
 do while rs_kehu.eof=false
%>
 <option value="<%=rs_kehu("ID")%>"><%=rs_kehu("RealName")%>,�ͻ����ͣ�<%=rs_kehu("CustomerType")%>��.</option>
<%
 rs_kehu.movenext
 loop
 rs_kehu.close
 set rs_kehu=nothing 
%>
 </select>
		  </td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> �ͻ���</td>
		  <td colspan="5" >
<%
 sql="select * from Customer where is_ok='true' and customerType>1 order by CustomerType "
 set rs_kehu=conn.execute(sql)
%>
 <select name="rank2" id="rank2" selfvalue="�ͻ�����">
 <option value="">��ѡ��</option>
<%
 do while rs_kehu.eof=false
%>
 <option value="<%=rs_kehu("ID")%>"><%=rs_kehu("RealName")%>,�ͻ����ͣ�<%=rs_kehu("CustomerType")%>��.</option>
<%
 rs_kehu.movenext
 loop
 rs_kehu.close
 set rs_kehu=nothing 
%>
 </select>
		  </td>
		</tr>
		<tr bgcolor='#FFFFFF'>
          <td align='right' bgcolor="#FFFFFF"> �������ڣ�</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="Gdate" type="text" id="Gdate" value="" onClick="WdatePicker()"></td>
        </tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ��ע��</td>
		  <td colspan="5"><textarea name="comment" cols="60" rows="5" id="comment" onKeyDown="next()"></textarea></td>
		</tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="6" >
		    <INPUT TYPE="hidden" name="action" id="action" value="list" >
	        <INPUT TYPE="hidden" name="addon" id="addon" value="yes" >
            <input type="submit" name="Submit" value="�ύ" onClick="check()">
          	<input type="button" name="Submit2" value="����" onClick="history.back(-1)"></td>
        </tr>
		</FORM>
      </table> 
<br>
  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="9"  class="optiontitle">������Ϣ</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
		  <td width="5%">ѡ��</td>
          <td width="10%">����</td>
          <td width="5%">�µ�|���</td>
          <td width="5%">���</td>
          <td width="8%">��������</td>
          <td width="5%">ҵ��Ա</td>
		  <td width="5%">���ƿͻ�</td>
          <td width="15%">��ע</td>
          <td width="8%">����</td>
        </tr>	
<%
 sql=" select a.*,b.����,b.���,c.RealName,b.����1,b.���1,d.RealName RealName1 from billInfo a left join billdetail_sum b on a.billno=b.billno left join Customer c on a.customer_id=c.id left join customer d on a.customer_id1=d.id where a.is_ok='TRUE' and a.billway='�µ�' and a.customer_id1 is not null order by a.status,billno desc "
 set rs=server.createobject("adodb.recordset") 
 rs.open sql,conn,1,1
 if not rs.eof then
 proCount=rs.recordcount
	rs.PageSize=8
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
     '-����ѭ����� start-
	 sc "<form name='del' action='' method='post'>"
	 sc "<tr align='center' bgcolor='#FFFFFF' onmouseover=""this.style.background='#F2FDFF'"" onmouseout=""this.style.background='#FFFFFF'"">"
	 if rs("status")=0 then 
	 sctd "<input type='checkbox' name='id' value='"&rs("id")&"'>"
	 elseif rs("status")=1 and rs("����1")=rs("����") then 
	 sctd ztgs("������",4)
	 elseif rs("status")=1 and rs("����1")>0 then 
	 sctd ztgs("������",4)
	 elseif rs("status")=1 and rs("����1")=0 then 
	 sctd ztgs("���ύ",4)
	 elseif rs("status")=2 then 
	 sctd ztgs("�����",2)
	 elseif rs("status")=3 then 
	 sctd ztgs("�����",1)
	 end if 
	 sctd rs("billno")
	 sctd rs("����")&"|"&rs("����1")
	 sctd rs("���")
	 sctd rs("GDATE")
	 sctd rs("RealName")
	 sctd rs("RealName1")
	 sctd rs("billnote")
	 sc "<td>"
	 sc "<IMG src='../images/view.gif' align='absmiddle'><a href='?action=view&id="&rs("id")&"'>�鿴</a>"
          if rs("status")= 0 then 
		  sc "| <IMG src='../images/edit.gif' align='absmiddle'><a href='?action=list&tj=yes&id="&rs("id")&"'>�ύ</a>"&_
		  " | <IMG src='../images/drop.gif' align='absmiddle'>"&_
		  "<a href=""javascript:DoEmpty('?wor=del&id="&rs("id")&"&action=list&ToPage="&intCurPage&"')"">ɾ��</a>"
          elseif rs("status")=1 then 
		  sc "| ���ύ"
		  elseif rs("status")=2 then 
		  sc "| <IMG src='../images/edit.gif' align='absmiddle'><a href='?action=list&tj=shou&id="&rs("id")&"'>�ջ�</a>"
		  elseif rs("status")=3 then 
		  sc "|"&ztgs("�����",1)
		  end if
		  sc "</td>"
		  sc "</tr>"
		  '-����ѭ����� end-
		  
          rs.movenext 
          next
		  %>
		<tr bgcolor="#F2FDFF">
		  <td colspan="9">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> ȫѡ
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="ɾ����ѡ" onClick="{if(confirm('ȷ��Ҫɾ����¼��ɾ���󽫱��޷��ָ���')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="9">�ܹ���
		  <font color="#ff0000"><%=rs.PageCount%></font>ҳ, 
		  <font color="#ff0000"><%=proCount%></font>����Ʒ��Ϣ, ��ǰҳ��
		  <font color="#ff0000"><%=intCurPage%> </font>
		  <%if intCurPage<>1 then%>
		  <a href="?action=list">��ҳ</a> | 
		  <a href="?action=list&ToPage=<%=intCurPage-1%>">��һҳ</a> | 
		  <% end if
             if intCurPage<>rs.PageCount then %>
          <a href="?action=list&ToPage=<%=intCurPage+1%>">��һҳ</a> | 
		  <a href="?action=list&ToPage=<%=rs.PageCount%>"> ���ҳ</a>
		  <% end if%>
		  </span>
		  </td>
        </tr>
<%
else
%>
        <tr align="center" bgcolor="#ffffff">
          <td colspan="9">�Բ���Ŀǰ���ݿ��л�û�������Ʒ��Ϣ��</td>
        </tr>
        <%
          rs.close
          set rs=nothing
          end if
        %>
      </table><br>
<%end if%>
<%if action="edit" then
set rs=server.createobject("adodb.recordset") 
sql="select * from GoodsInfo where id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
       <form name="add" method="post" action="goods.asp">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> ��Ʒ��Ϣ </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> ��Ʒ���ƣ�</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" value="<%=rs("gname")%>" size="50" maxlength="50" onKeyDown="next()"> 
          ���س�\TAB������������һѡ��</td>
        </tr>		
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ��Ʒ���</td>
		  <td><input name="address" type="text" id="address" value="<%=rs("Gcat")%>" onKeyDown="next()"></td>
		  <td align='right'>�ɹ��ɱ���</td>
		  <td><input name="pcode" type="text" id="pcode" value="<%=rs("gcost")%>" onKeyDown="next()"></td>
		  <td align='right'>���ۼ۸�</td>
		  <td><input name="owner" type="text" id="owner" value="<%=rs("gsell")%>" onKeyDown="next()"></td>
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
viewaction=request("viewaction")
if viewaction="yes" then 
 if is_sku("Gname","GoodsInfo","'"&request("dname")&"'")=1 then 
  'sc "�иÿ�ʽ��"
  if is_sku("billno|goodsid","billdetail","'"&request("danno")&"'|'"&request("dname")&"'")=0 then 
  call dbdo(1,"billdetail","billno|goodsid|billqyt|cuser-'"&request("danno")&"'|'"&request("dname")&"'|"&request("dqyt")&"|'"&session("RealName")&"'")
  else 
  sql="update billdetail set billqyt=billqyt +"&request("dqyt")&" where billno='"&request("danno")&"' and goodsid='"&request("dname")&"' "
  call dbdo(2,sql,sql)
  'sc sql
  end if 
 else
 sc "����Ʒ�����ڣ�"
 end if 
end if 
set rs=server.createobject("adodb.recordset") 
'sql="select * from billInfo where id="&Request("id")
sql="select * from billInfo where id="&id
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	    <form action="dbill.asp?action=view&id=<%=id%>" method="POST" name="billd" id="billd">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=4  class="optiontitle"> ���ţ�<%=rs("billno")%> <input type="hidden" id="viewaction" name="viewaction" value="yes"> 
		  <input type="hidden" id="danno" name="danno" value="<%=rs("billno")%>"></td>
		</tr>
	    <tr bgcolor='#EBF0F7' align='center'>
		  <td>ѡ��</td>
		  <td>��Ʒ</td>
		  <td>����</td>
		  <td>����</td>
		</tr>
<%
   sql2="select * from billdetail where billno='"&rs("billno")&"'  "
   set rs2=server.createobject("adodb.recordset") 
   rs2.open sql2,conn,1,1
   if not rs.eof then
	 For i = 0 to rs2.recordcount
	 if rs2.eof then     
	 Exit For 
	 end if
%>
	    <tr bgcolor='#FFFFFF' align='center'>
		  <td><input type="checkbox" name="id" value="<%=rs2("id")%>"></td>
		  <td><%=rs2("goodsid")%></td>
		  <td><%=rs2("billqyt")%>|<%=rs2("ProductQty")%></td>
		  <td><% if rs("status")= 0 then %><IMG src="../images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del2&id=<%=rs2("id")%>&danno=<%=id%>&action=view')">ɾ��</a><% end if %></td>
		</tr>
<%
   rs2.movenext 
   next
   rs2.close
   set rs2=nothing
   end if
   if rs("status")= 0 then 
%>
	    <tr bgcolor='#FFFFFF' align='center'>
		  <td >������Ʒ��</td>
		  <td>����:<input id="dqyt" name="dqyt" size="4" value="1"></td>
		  <td ><input id="dname" name="dname" style="width:100%" /></td>
		  <td><input type="Submit" name="Submit3" value="�ύ" ></td>
		</tr>
<%
end if 
%>
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6 > ������ע��<%=rs("BillNote")%></td>
		</tr>
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6 > �������ڣ�<%=rs("Gdate")%></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="4"><a href='?action=list'><u><strong><em>����</em></strong></u></a>
          <!--<input type="button" name="Submit2" value="����" onClick="history.back(-1)">--></td>
		</tr>
		</form>
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