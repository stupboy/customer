<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<%
'-ɾ����¼ is_ok='false'-
if Request("wor")="del" then
 id=request("id")
 idArr=split(id,",")
 for i=0 to ubound(idArr)
  sql="update GoodsInfo set is_ok='false' where id="&trim(idArr(i))
  conn.execute(sql)
 next
end if
%>
<%
'-��Ӻ��޸ļ�¼ idΪ����Ϊ��� ����Ϊ�޸�-
action=Request("action")
id=Request("id")
if action="yes" Then
 set rs=server.createobject("adodb.recordset") 
if id="" then
   set rsCheck = conn.execute("select Gname from GoodsInfo where Gname='" & trim(Request.Form("cname")) & "'")
     if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('��Ʒ��Ʒ��� " & trim(Request.Form("idcard")) & " �Ѵ��ڣ����飡');history.back(-1);</script>"
      response.end
     end if
   set rsCheck=nothing
   '-����6���㼶�۸�-
   sql="insert into Goods_InPrice (CustomerType,Gname,InPrice) values ('1','"&Request("cname")&"',"&Request("T1")&") "
   conn.execute(sql)
   sql="insert into Goods_InPrice (CustomerType,Gname,InPrice) values ('2','"&Request("cname")&"',"&Request("T2")&") "
   conn.execute(sql)
   sql="insert into Goods_InPrice (CustomerType,Gname,InPrice) values ('3','"&Request("cname")&"',"&Request("T3")&") "
   conn.execute(sql)
   sql="insert into Goods_InPrice (CustomerType,Gname,InPrice) values ('4','"&Request("cname")&"',"&Request("T4")&") "
   conn.execute(sql)
   sql="insert into Goods_InPrice (CustomerType,Gname,InPrice) values ('5','"&Request("cname")&"',"&Request("T5")&") "
   conn.execute(sql)
   sql="insert into Goods_InPrice (CustomerType,Gname,InPrice) values ('6','"&Request("cname")&"',"&Request("T6")&") "
   conn.execute(sql)
   sql="select * from GoodsInfo " 
   rs.open sql,conn,3,3
   rs.addnew
else
   '-����6���㼶�۸�-
   sql="update Goods_InPrice set InPrice="&Request("T1")&" where  CustomerType='1' and Gname='"&Request("cname")&"' "
   conn.execute(sql)
   sql="update Goods_InPrice set InPrice="&Request("T2")&" where  CustomerType='2' and Gname='"&Request("cname")&"' "
   conn.execute(sql)
   sql="update Goods_InPrice set InPrice="&Request("T3")&" where  CustomerType='3' and Gname='"&Request("cname")&"' "
   conn.execute(sql)
   sql="update Goods_InPrice set InPrice="&Request("T4")&" where  CustomerType='4' and Gname='"&Request("cname")&"' "
   conn.execute(sql)
   sql="update Goods_InPrice set InPrice="&Request("T5")&" where  CustomerType='5' and Gname='"&Request("cname")&"' "
   conn.execute(sql)
   sql="update Goods_InPrice set InPrice="&Request("T6")&" where  CustomerType='6' and Gname='"&Request("cname")&"' "
   conn.execute(sql)
   sql="select * from GoodsInfo " 
   sql="select * from GoodsInfo where id="&id&"" 
   rs.open sql,conn,1,2
end if
rs("Gname")=Request("cname")
rs("Gcat")=Request("address")
rs("Gcost")=Request("pcode")
rs("Gsell")=Request("owner")
'rs("Gnote")=ssql
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
<title>���۹���ϵͳ</title>
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
<%if action="Yuan" then%>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="4"  class="optiontitle">ԭ�Ͽ��������Ϣ</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td width="10%">���</td>
          <td width="10%">���</td>
          <td width="10%">����</td>
          <td width="10%">�ɱ�</td>
        </tr>	
<%
 sql="select a.Yname,sum(Yqty) qty,sum(Yqty*Yprice) money from Yuan_Store a left join Yuan_Info b on a.Yname=b.Yname group by a.Yname"
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
%>
       <form name="del" action="" method="post">
        <tr align='center' bgcolor='#FFFFFF' onmouseover='this.style.background="#F2FDFF"' onmouseout='this.style.background="#FFFFFF"'>
		  <td><%=i%></td>
          <td><%=rs("Yname")%></td>
		  <td><%=rs("qty")%></td>
          <td><%=rs("money")%></td>
        </tr>
<%
rs.movenext 
next
%>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="4">�ܹ���
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
          <td colspan="4">�Բ���Ŀǰ���ݿ��л�û�������Ʒ��Ϣ��</td>
        </tr>
        <%
          rs.close
          set rs=nothing
          end if
        %>
      </table><br>
<%end if%>
<%
if action="goods" then
sc "<table width='96%'  border='0' align='center' cellpadding='4' cellspacing='1' bgcolor='#aec3de'>"
sc "<tr align='center' bgcolor='#F2FDFF'>"
sc "<td colspan='4'  class='optiontitle'>ԭ�Ͽ��������Ϣ</td>"
sc "</tr>"
sc "<tr align='center' bgcolor='#ebf0f7'>"
sc "<td width='10%'>���</td>"
sc "<td width='10%'>���</td>"
sc "<td width='10%'>����</td>"
sc "<td width='10%'>�ɱ�</td>"
sc "</tr>"	
'-���ݲ�ѯ-
sql="select * from storedetail_sum order by customer,goodsid "
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

sc "<form name='del' action='' method='post'>"
sc "<tr align='center' bgcolor='#FFFFFF' onmouseover=""this.style.background='#F2FDFF'"" onmouseout=""this.style.background='#FFFFFF'"">"
sctd rs("Customer")
sctd rs("Goodsid")
sctd rs("����1")
sctd rs("���1")
sc "</tr>"
rs.movenext 
next
%>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="4">�ܹ���
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
          <td colspan="4">�Բ���Ŀǰ���ݿ��л�û�������Ʒ��Ϣ��</td>
        </tr>
        <%
          rs.close
          set rs=nothing
          end if
        %>
      </table><br>
<%end if%>
    </td>
  </tr>
</table>
</body>
</html>