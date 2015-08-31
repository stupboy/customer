<!--#include file="inc/right.asp"--> 
<!--#include file="inc/conn.asp"-->
<%
if Request("wor")="del" then
id=request("id")
idArr=split(id,",")
for i=0 to ubound(idArr)
sql="delete from Information where id="&trim(idArr(i))
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
   set rsCheck = conn.execute("select idcard from Information where idcard='" & trim(Request.Form("idcard")) & "'")
     if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('客户客户编号 " & trim(Request.Form("idcard")) & " 已存在，请检查！');history.back(-1);</script>"
      response.end
     end if
   set rsCheck=nothing
   sql="select * from Information" 
   rs.open sql,conn,3,3
   rs.addnew
else
   sql="select * from Information where id="&id&"" 
   rs.open sql,conn,1,2
end if
rs("cname")=Request("cname")
rs("idcard")=Request("idcard")
rs("rank")=Request("rank")
rs("address")=Request("address")
rs("pcode")=Request("pcode")
rs("owner")=Request("owner")
rs("phone")=Request("phone")
rs("fax")=Request("fax")
rs("email")=Request("email")
rs("www")=Request("www")
rs("addtime")=Request("addtime")
rs("comment")=Request("comment")
 rs.update
 rs.close
set rs=nothing
 Response.Redirect "?action=list"
end if
%>
<html>
<head>
<title>校无忧管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="images/main.css" rel="stylesheet" type="text/css">
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
if (confirm("真的要删除这条记录吗？删除后此记录里的所有内容都将被删除并且无法恢复！"))
window.location = params ;
}

function check()
{

  if (document.add.cname.value=="")
     {
      alert("请填写客户名称！")
      document.add.cname.focus()
      document.add.cname.select()
      return
     }
	 
  if (document.add.idcard.value=="")
     {
      alert("请填写客户编号！")
      document.add.idcard.focus()
      document.add.idcard.select()
      return
     }
	 
  if (document.add.rank.value=="")
     {
      alert("请选择客户级别！")
      document.add.rank.focus()
      document.add.rank.select()
      return
     }
  
  if (document.add.owner.value=="")
     {
      alert("请填写责任人！")
      document.add.owner.focus()
      document.add.owner.select()
      return
     }
	 
  if (document.add.phone.value=="")
     {
      alert("请填写联系电话！")
      document.add.phone.focus()
      document.add.phone.select()
      return
     }

  if (document.add.addtime.value=="")
     {
      alert("请填写录取时间！")
      document.add.addtime.focus()
      document.add.addtime.select()
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
	<%if action="add" then%><BR>
        <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="Information.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="6"  class="optiontitle"> 添加客户信息 </td>
        </tr>
        <tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> 名称：</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" onKeyDown="next()" size="50" maxlength="50" > 
            按回车\TAB键即可输入下一选项</td>
        </tr>		
       <%idcard=year(now())&month(now())&day(now())&hour(now())&minute(now())&second(now())%>
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">编号：</td>
		  <td colspan="5"><input name="idcard" type="text" id="idcard" onKeyDown="next()" value="KH<%=idcard%>" > </td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 级别：</td>
		  <td colspan="5" >
           <select name="rank" id="rank" selfvalue="客户级别">
              <option value="">请选择</option>
              <option value="1">★</option>
              <option value="2">★★</option>
              <option value="3">★★★</option>
              <option value="4">★★★★</option>
              <option value="5">★★★★★</option>
            </select>
		  </td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 地址：</td>
		  <td><input name="address" type="text" id="address" onKeyDown="next()"></td>
		  <td align='right'>邮编：</td>
		  <td><input name="pcode" type="text" id="pcode" onKeyDown="next()"></td>
		  <td align='right'>责任人：</td>
		  <td><input name="owner" type="text" id="owner" onKeyDown="next()"></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 电话：</td>
		  <td><input name="phone" type="text" id="phone" onKeyDown="next()"></td>
		  <td align='right'>传真：</td>
		  <td><input name="fax" type="text" id="fax" onKeyDown="next()"></td>
		  <td align='right'>Email：</td>
		  <td><input name="email" type="text" id="email" onKeyDown="next()"></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF">网址：</td>
		  <td colspan="5" ><input name="www" type="text" id="www" onKeyDown="next()"></td>
		</tr>
	    <tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 日期：</td>
		  <td colspan="5"><input name="addtime" type="text" id="addtime" value="<%response.write date()%>" onKeyDown="next()" ></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 备注：</td>
		  <td colspan="5"><textarea name="comment" cols="60" rows="5" id="comment" onKeyDown="next()"></textarea></td>
		</tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="6" >
		     <INPUT TYPE="hidden" name="action" value="yes">
            <input type="button" name="Submit" value="提交" onClick="check()">
          	<input type="button" name="Submit2" value="返回" onClick="history.back(-1)"></td>
        </tr>
		</FORM>
      </table> 
<%end if%>
<br>
<%if action="list" then%>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="8"  class="optiontitle">客户信息</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
		  <td width="50">选中</td>
          <td width="10%">客户编号</td>
          <td width="15%">客户名称</td>
          <td width="10%">客户级别</td>
          <td width="10%">责任人</td>
          <td width="15%">电话</td>
          <td width="20%">Email</td>
          <td>执行操作</td>
        </tr>	
<%
sql="select * from Information order by id desc"
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
          <td><%=rs("idcard")%></td>
		  <td><%=rs("cname")%></td>
          <td>
		  <%if rs("rank")="1" Then%>★<%end if%>
          <%if rs("rank")="2" Then%>★★<%end if%>
		  <%if rs("rank")="3" Then%>★★★<%end if%>
		  <%if rs("rank")="4" Then%>★★★★<%end if%>
		  <%if rs("rank")="5" Then%>★★★★★<%end if%></td>
		  <td><%=rs("owner")%></td>
		  <td><%=rs("phone")%></td>
		  <td><%=rs("email")%></td>
          <td><IMG src="images/view.gif" align="absmiddle"><a href="?action=view&id=<%=rs("id")%>">查看</a> | <IMG src="images/edit.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">修改</a> | <IMG src="images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("id")%>&action=list&ToPage=<%=intCurPage%>')">删除</a></td>
        </tr>
<%
rs.movenext 
next
%>
		<tr bgcolor="#F2FDFF">
		  <td colspan="8">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> 全选
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="删除所选" onClick="{if(confirm('确定要删除记录吗？删除后将被无法恢复！')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="8"> 总共：<font color="#ff0000"><%=rs.PageCount%></font>页, <font color="#ff0000"><%=proCount%></font>条客户信息, 当前页：<font color="#ff0000"><%=intCurPage%> </font><%if intCurPage<>1 then%><a href="?action=list">首页</a> | <a href="?action=list&ToPage=<%=intCurPage-1%>">上一页</a> | <% end if
if intCurPage<>rs.PageCount then %><a href="?action=list&ToPage=<%=intCurPage+1%>">下一页</a> | <a href="?action=list&ToPage=<%=rs.PageCount%>"> 最后页</a><% end if%></span></td>
        </tr>
<%
else
%>
        <tr align="center" bgcolor="#ffffff">
          <td colspan="8">对不起！目前数据库中还没有添加客户信息！</td>
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
sql="select * from Information where id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
       <form name="add" method="post" action="Information.asp">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> 客户信息 </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> 名称：</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" value="<%=rs("cname")%>" size="50" maxlength="50" onKeyDown="next()"> 
          按回车\TAB键即可输入下一选项</td>
        </tr>		
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">编号：</td>
		  <td colspan="5" align="left"><input name="idcard" type="text" id="idcard" value="<%=rs("idcard")%>" onKeyDown="next()"></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 级别：</td>
		  <td colspan="5" >
		  <select name="rank" selfvalue="客户级别">
            <option value="">请选择</option>
            <option value="1" <% if rs("rank")="1" Then Response.write("Selected")%>>★</option>
            <option value="2" <% if rs("rank")="2" Then Response.write("Selected")%>>★★</option>
            <option value="3" <% if rs("rank")="3" Then Response.write("Selected")%>>★★★</option>
            <option value="4" <% if rs("rank")="4" Then Response.write("Selected")%>>★★★★</option>
            <option value="5" <% if rs("rank")="5" Then Response.write("Selected")%>>★★★★★</option>
          </select>
		  </td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 地址：</td>
		  <td><input name="address" type="text" id="address" value="<%=rs("address")%>" onKeyDown="next()"></td>
		  <td align='right'>邮编：</td>
		  <td><input name="pcode" type="text" id="pcode" value="<%=rs("pcode")%>" onKeyDown="next()"></td>
		  <td align='right'>责任人：</td>
		  <td><input name="owner" type="text" id="owner" value="<%=rs("owner")%>" onKeyDown="next()"></td>
		</tr>
		
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 电话：</td>
		  <td><input name="phone" type="text" id="phone" value="<%=rs("phone")%>" onKeyDown="next()"></td>
		  <td align='right'>传真：</td>
		  <td><input name="fax" type="text" id="fax" value="<%=rs("fax")%>" onKeyDown="next()"></td>
		  <td align='right'>Email：</td>
		  <td><input name="email" type="text" id="email" value="<%=rs("email")%>" onKeyDown="next()"></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF">网址：</td>
		  <td colspan="5" ><input name="www" type="text" id="www" value="<%=rs("www")%>" onKeyDown="next()"></td>
		</tr>
	    <tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 日期：</td>
		  <td colspan="5" ><input name="addtime" type="text" id="addtime" value="<%=rs("addtime")%>" onKeyDown="next()"></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 备注：</td>
		  <td colspan="5" ><textarea name="comment" cols="60" rows="5" id="comment" onKeyDown="next()"><%=rs("comment")%></textarea></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="6">
		  <input type="hidden" name="action" value="yes">
          <input type="button" name="Submit2" value="提交" onClick="check()">
          <input type="button" name="Submit2" value="返回" onClick="history.back(-1)">
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
sql="select * from Information where id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> 客户信息 </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> 名称：</td>
          <td colspan="5" bgcolor="#FFFFFF"><%=rs("cname")%></td>
        </tr>		
		<tr bgcolor="#F2FDFF">
		  <td width="10%" align="right">编号：</td>
		  <td colspan="5" align="left"><%=rs("idcard")%></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 级别：</td>
		  <td colspan="5" >
		  <% if rs("rank")="1" Then Response.write("★")%>
		  <% if rs("rank")="2" Then Response.write("★★")%>
          <% if rs("rank")="3" Then Response.write("★★★")%>
          <% if rs("rank")="4" Then Response.write("★★★★")%>
          <% if rs("rank")="5" Then Response.write("★★★★★")%>
		  </td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 地址：</td>
		  <td><%=rs("address")%></td>
		  <td align='right'>邮编：</td>
		  <td><%=rs("pcode")%></td>
		  <td align='right'>责任人：</td>
		  <td><%=rs("owner")%></td>
		</tr>
		
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 电话：</td>
		  <td><%=rs("phone")%></td>
		  <td align='right'>传真：</td>
		  <td><%=rs("fax")%></td>
		  <td align='right'>Email：</td>
		  <td><%=rs("email")%></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF">网址：</td>
		  <td colspan="5" ><%=rs("www")%></td>
		</tr>
	    <tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 日期：</td>
		  <td colspan="5" ><%=rs("addtime")%></td>
		</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 备注：</td>
		  <td colspan="5" ><%=rs("comment")%></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="6">
          <input type="button" name="Submit2" value="返回" onClick="history.back(-1)"></td>
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