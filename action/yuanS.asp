<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<%
'-��Ӻ��޸ļ�¼ idΪ����Ϊ��� ����Ϊ�޸�-
'-��ȡ���ݱ���-
action=Request("action")
addon=Request("addon")
id=Request("id")

'-ɾ����¼ is_ok='false'-
if Request("wor")="del" then
 id=request("id")
  sql="delete from Yuan_Store  where Ydanno='"&id&"' "
  conn.execute(sql)
elseif Request("wor")="sh" then 
  sql="update Yuan_Store set Ystatus=1  where Ydanno='"&id&"' "
  conn.execute(sql)
elseif Request("wor")="del2" then
 id=request("id")
 idArr=split(id,",")
 for i=0 to ubound(idArr)
  sql="delete from Yuan_Store where id="&trim(idArr(i))
  conn.execute(sql)
 next 
  id=request("danno")
elseif Request("addon")="yes" then  
 Tstr=replace(replace(Trim(Request("comment")),"<br>","#"),"_x_","|")
 mY0=split(Tstr,"#")
 for i= 1 to ubound(mY0)
 mY1=split(mY0(i),"|")
 sql="insert into Yuan_Store (Yname,yqty,ydanno,ystatus,ydancat,CreateUser) values ('"&mY1(0)&"',"&mY1(1)&",'"&Request("billno")&"',0,'�ɹ����','"&session("RealName")&"')"
 conn.execute(sql)
 'sc sql
 next 
 'sc gstr
 sql="insert into Yuan_Store (billno,status,cuser,billway) values ('"&Request("billno")&"',0,'"&session("RealName")&"','�µ�')"
 'conn.execute(sql)
end if

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
<script language=JavaScript type=text/JavaScript>
 function yuanadd()
{
 var s1=document.getElementById("comment");
 var s2=document.getElementById("rank");
 var s3=document.getElementById("yqty");
 var s0=document.getElementById("Yxx");
 var ss=s1.value;
 if (s2.value !="")
 {
  if (ss.indexOf(s2.value)>0)
  {
  //alert(ss.substr(ss.indexOf(s2.value)-4,10));
  ss1=ss.substr(ss.indexOf(s2.value),999)+"<br>";
  ss2=ss.substr(ss.indexOf(s2.value)-4,ss1.indexOf("<br>")+4)
  s1.value=ss.replace(ss2,"") + "<br>" + s2.value + "_x_" + s3.value
  s0.innerHTML=s1.value
  //alert(ss1.indexOf("<br>"));
  //alert(ss2);
  }else{
   s1.value=s1.value + "<br>" + s2.value + "_x_" + s3.value
   s0.innerHTML=s1.value
   }
 }
}
</script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF">
<!--���Ӷ��� �� �����б�-->
<%if action="list" then%>
        <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="yuanS.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="6"  class="optiontitle"> ��ӿͻ���Ϣ </td>
        </tr>
        <tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#F2FDFF"> ���ţ�</td>
          <td colspan="5" bgcolor="#F2FDFF"><input name="billno" type="text" id="billno" value="<%=danhao("Y")%>" size="30" maxlength="50" readonly="readonly" > 
            ���س�\TAB������������һѡ��</td>
        </tr>		
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> �ͻ���</td>
		  <td colspan="5" >
<%
 sql="select * from Yuan_Info where is_ok='True' "
 set rs_kehu=conn.execute(sql)
%>
 <select name="rank" id="rank" selfvalue="�ͻ�����">
 <option value="">��ѡ��</option>
<%
 do while rs_kehu.eof=false
%>
 <option value="<%=rs_kehu("Yname")%>"><%=rs_kehu("Yname")%>/<%=rs_kehu("Ydan")%></option>
<%
 rs_kehu.movenext
 loop
 rs_kehu.close
 set rs_kehu=nothing 
%>
 </select><input type="text" value="1" name="yqty" id="yqty" size="5" /><input type="button" value="�������" name="SADD" id="SADD" onclick="return yuanadd()" />
</td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> �����Ϣ��</td>
		  <td colspan="5"><INPUT TYPE="hidden" name="comment" id="comment" value="" ></textarea><span id="Yxx"></span></td>
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
          <td colspan="5"  class="optiontitle">��Ʒ��Ϣ</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
		  <td width="5%">״̬</td>
          <td width="10%">����</td>
          <td width="10%">����</td>
          <td width="10%">���</td>
          <td width="10%">����</td>
        </tr>	
<%
 sql=" select a.yway,a.Ystatus,a.Ydanno,sum(a.yqty) TotalQty,sum(a.yqty*Yprice) TotalMoney from Yuan_store a LEFT JOIN Yuan_Info b  on a.Yname=b.Yname group by yway,Ystatus,Ydanno "
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
	 YSH="<span style='color:#FFFFFF;background-color:#009900;'><strong>�����</strong></span>"
SX="<strong>|</strong>"
RK="<span style='background-color:#B8D100;'><strong>���</strong></span>"
WSH="<span style='color:#FFFFFF;background-color:#E53333;'><strong>δ���</strong></span>"
HX="<span style='background-color:#FF9900;'><strong>����</strong></span>"
%>
       <form name="del" action="" method="post">
        <tr align='center' bgcolor='#FFFFFF' onmouseover='this.style.background="#F2FDFF"' onmouseout='this.style.background="#FFFFFF"'>
          <td>
		  <%
		  if rs("Ystatus") = 0 then 
		  sc ztgs("δ���",2)&ztgs("|",9)&ztgs(rs("Yway"),2)
		  else 
		  sc ztgs("�����",1)&ztgs("|",9)&ztgs(rs("Yway"),2)
		  end if 
		  %>
		  </td>
		  <td><%=rs("Ydanno")%></td>
          <td><%=rs("TotalQty")%></td>
		  <td><%=rs("TotalMoney")%></td>
          <td><IMG src="../images/view.gif" align="absmiddle"><a href="?action=view&id=<%=rs("Ydanno")%>">�鿴</a> 
		  <% if rs("Ystatus") = 0 then %>
		  | <IMG src="../images/drop.gif" align="absmiddle"><a href="?wor=sh&id=<%=rs("Ydanno")%>&action=list&ToPage=<%=intCurPage%>">���</a>
		  <% end if %>
		  </td>
        </tr>
<%
rs.movenext 
next
%>
<!--
		<tr bgcolor="#F2FDFF">
		  <td colspan="5">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> ȫѡ
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="ɾ����ѡ" onClick="{if(confirm('ȷ��Ҫɾ����¼��ɾ���󽫱��޷��ָ���')){return true;}return false;}" />
		  </td>
		</tr>-->
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="5">�ܹ���
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
          <td colspan="5">�Բ���Ŀǰ���ݿ��л�û�������Ʒ��Ϣ��</td>
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
 if is_sku("Yname","Yuan_Info","'"&request("dname")&"'")=1 then 
  'sc "�иÿ�ʽ��"
  if is_sku("Ydanno|Yname","Yuan_Store","'"&request("danno")&"'|'"&request("dname")&"'")=0 then 
  call dbdo(1,"Yuan_Store","Ydanno|Yname|Yqty|CreateUser|Ydancat-'"&request("danno")&"'|'"&request("dname")&"'|"&request("dqyt")&"|'"&session("RealName")&"'|'�ɹ����'")
  else 
  sql="update Yuan_Store set Yqty=Yqty +"&request("dqyt")&" where Ydanno='"&request("danno")&"' and Yname='"&request("dname")&"' "
  call dbdo(2,sql,sql)
  end if 
 else
 sc "����Ʒ�����ڣ�"
 end if 
end if 
if request.querystring("danno")<>"" then 
Cdanhao=request.querystring("danno")
end if 
set rs=server.createobject("adodb.recordset") 
sql="select a.*,b.Yprice from Yuan_Store a left join Yuan_Info b on a.Yname=b.Yname where a.Ydanno='"&ID&"' "
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	    <form action="yuanS.asp?action=view&id=<%=id%>" method="POST" name="billd" id="billd">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> ���ţ�<%=id%> <input type="hidden" id="viewaction" name="viewaction" value="yes"> 
		  <input type="hidden" id="danno" name="danno" value="<%=ID%>"></td>
		</tr>
	    <tr bgcolor='#EBF0F7' align='center'>
		  <td>ѡ��</td>
		  <td>��Ʒ</td>
		  <td>���</td>
		  <td>����</td>
		  <td>���</td>
		  <td>����</td>
		</tr>
<%
rs.open sql,conn,1,1
if not rs.eof Then
for i = 1 to rs.recordcount
%>
	    <tr bgcolor='#FFFFFF' align='center'>
		  <td><input type="checkbox" name="id" value="<%=rs("id")%>"></td>
		  <td><%=rs("Ydanno")%></td>
		  <td><%=rs("Yname")%></td>
		  <td><%=rs("Yqty")%></td>
		  <td><%=rs("Yprice")*rs("Yqty")%></td>
		  <td>
		  <%
		  if rs("Ystatus")=0 then 
		  %>
		  <IMG src="../images/drop.gif" align="absmiddle">
		  <a href="javascript:DoEmpty('?wor=del2&id=<%=rs("id")%>&danno=<%=id%>&action=view')">ɾ��</a>
		  <%
		  else 
		  sc ztgs("�����",1)
		  end if  
		  %>
		  </td>
		</tr>
<%
kk=rs("ystatus")
rs.movenext 
next 
if kk=0 then 
%>
	    <tr bgcolor='#FFFFFF' align='center'>
		  <td colspan=2>������Ʒ��</td>
		  <td>����:<input id="dqyt" name="dqyt" size="4" value="1"></td>
		  <td colspan=2><input id="dname" name="dname" style="width:100%" /></td>
		  <td><input type="Submit" name="Submit3" value="�ύ" ></td>
		</tr>
<%
end if
%>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="6">
          <input type="button" name="Submit2" value="����" onClick="history.back(-1)"></td>
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