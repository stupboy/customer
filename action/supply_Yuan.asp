<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<%
'-添加和修改记录 id为空则为添加 否则为修改-
'-获取传递变量-
action=Request("action")
addon=Request("addon")
id=Request("id")

'-删除记录 is_ok='false'-
if Request("wor")="del" then
 id=request("id")
  sql="delete from Yuan_supply_detail  where supplyid='"&id&"' "
  conn.execute(sql)
  sc sql

elseif Request("wor")="del2" then
 id=request("id")
 idArr=split(id,",")
 for i=0 to ubound(idArr)
  sql="delete from Yuan_supply_detail where id="&trim(idArr(i))
  conn.execute(sql)
 next 
  id=request("danno")
elseif Request("addon")="yes" then  
 sql="delete from yuan_supply_detail  where supplyid='"&Request("billno")&"' "
 conn.execute(sql)
 Tstr=replace(replace(Trim(Request("comment")),"<br>","#"),"_x_","|")
 mY0=split(Tstr,"#")
 for i= 1 to ubound(mY0)
 mY1=split(mY0(i),"|")
 sql="insert into yuan_supply_detail (Yname,Yprice,supplyID) values ('"&mY1(0)&"',"&mY1(1)&",'"&Request("billno")&"')"
 conn.execute(sql)
 next 
end if

'--增加商品信息记录-
if action="yes" Then
 set rs=server.createobject("adodb.recordset") 
 if id="" then
   set rsCheck = conn.execute("select Gname from GoodsInfo where Gname='" & trim(Request.Form("cname")) & "'")
     if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('商品商品编号 " & trim(Request.Form("idcard")) & " 已存在，请检查！');history.back(-1);</script>"
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
<title>订单管理</title>
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
if (confirm("真的要删除这条记录吗？删除后此记录里的所有内容都将被删除并且无法恢复！"))
window.location = params ;
}

function check()
{

  if (document.add.cname.value=="")
     {
      alert("请填写商品名称！")
      document.add.cname.focus()
      document.add.cname.select()
      return
     }
	 
  if (document.add.address.value=="")
     {
      alert("请填写商品类别！")
      document.add.address.focus()
      document.add.address.select()
      return
     }
	 
  if (document.add.pcode.value=="")
     {
      alert("商品采购成本！")
      document.add.pcode.focus()
      document.add.pcode.select()
      return
     }
  
  if (document.add.owner.value=="")
     {
      alert("商品零售价格！")
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
<!--增加订单 及 订单列表-->
<%if action="list" then%>
        <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="supply_yuan.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="6"  class="optiontitle"> 添加供应信息 </td>
        </tr>		
<tr bgcolor='#FFFFFF'>
<td align='right' bgcolor="#FFFFFF"> 供应商：</td>
<td colspan="5" >
<%
 sql="select * from yuan_supply where is_ok='True' "
 set rs_kehu=conn.execute(sql)
%>
 <select name="billno" id="billno" selfvalue="商品类别">
 <option value="">请选择</option>
<%
 do while rs_kehu.eof=false
%>
 <option value="<%=rs_kehu("supply")%>"><%=rs_kehu("supply")%></option>
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
		  <td align='right' bgcolor="#FFFFFF"> 原料：</td>
		  <td colspan="5" >
<%
 sql="select * from Yuan_Info where is_ok='True' "
 set rs_kehu=conn.execute(sql)
%>
 <select name="rank" id="rank" selfvalue="客户级别">
 <option value="">请选择</option>
<%
 do while rs_kehu.eof=false
%>
 <option value="<%=rs_kehu("Yname")%>"><%=rs_kehu("Yname")%>_元/<%=rs_kehu("Ydan")%></option>
<%
 rs_kehu.movenext
 loop
 rs_kehu.close
 set rs_kehu=nothing 
%>
 </select><input type="text" value="1" name="yqty" id="yqty" size="5" /><input type="button" value="继续添加" name="SADD" id="SADD" onclick="return yuanadd()" />
</td>
</tr>
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 单价信息：</td>
		  <td colspan="5"><INPUT TYPE="hidden" name="comment" id="comment" value="" ></textarea><span id="Yxx"></span></td>
		</tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="6" >
		    <INPUT TYPE="hidden" name="action" id="action" value="list" >
	        <INPUT TYPE="hidden" name="addon" id="addon" value="yes" >
            <input type="submit" name="Submit" value="提交" onClick="check()">
          	<input type="button" name="Submit2" value="返回" onClick="history.back(-1)"></td>
        </tr>
		</FORM>
      </table> 
<br>
  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="5"  class="optiontitle">商品信息</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
		  <td width="5%">选中</td>
          <td width="10%">供应商</td>
          <td width="10%">供应数量</td>
          <td width="10%"></td>
          <td width="10%">操作</td>
        </tr>	
<%
 sql=" select supply,count(distinct yname) supplys from Yuan_supply_info group by supply having count(distinct yname)<>0  "
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
          <td><input type="checkbox" name="id" value="<%=rs("supply")%>"></td>
		  <td><%=rs("supply")%></td>
          <td><%=rs("supplys")%></td>
		  <td></td>
          <td><IMG src="../images/view.gif" align="absmiddle"><a href="?action=view&id=<%=rs("supply")%>">查看</a> | <IMG src="../images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("supply")%>&action=list&ToPage=<%=intCurPage%>')">删除</a></td>
        </tr>
<%
rs.movenext 
next
%>
		<tr bgcolor="#F2FDFF">
		  <td colspan="5">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> 全选
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="删除所选" onClick="{if(confirm('确定要删除记录吗？删除后将被无法恢复！')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="5">总共：
		  <font color="#ff0000"><%=rs.PageCount%></font>页, 
		  <font color="#ff0000"><%=proCount%></font>条商品信息, 当前页：
		  <font color="#ff0000"><%=intCurPage%> </font>
		  <%if intCurPage<>1 then%>
		  <a href="?action=list">首页</a> | 
		  <a href="?action=list&ToPage=<%=intCurPage-1%>">上一页</a> | 
		  <% end if
             if intCurPage<>rs.PageCount then %>
          <a href="?action=list&ToPage=<%=intCurPage+1%>">下一页</a> | 
		  <a href="?action=list&ToPage=<%=rs.PageCount%>"> 最后页</a>
		  <% end if%>
		  </span>
		  </td>
        </tr>
<%
else
%>
        <tr align="center" bgcolor="#ffffff">
          <td colspan="5">对不起！目前数据库中还没有添加商品信息！</td>
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
		  <td colspan=6  class="optiontitle"> 商品信息 </td>
		</tr>
		<tr bgcolor='#F2FDFF'>
          <td align='right' bgcolor="#FFFFFF"> 商品名称：</td>
          <td colspan="5" bgcolor="#FFFFFF"><input name="cname" type="text" id="cname" value="<%=rs("gname")%>" size="50" maxlength="50" onKeyDown="next()"> 
          按回车\TAB键即可输入下一选项</td>
        </tr>		
		<tr bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 商品类别：</td>
		  <td><input name="address" type="text" id="address" value="<%=rs("Gcat")%>" onKeyDown="next()"></td>
		  <td align='right'>采购成本：</td>
		  <td><input name="pcode" type="text" id="pcode" value="<%=rs("gcost")%>" onKeyDown="next()"></td>
		  <td align='right'>销售价格：</td>
		  <td><input name="owner" type="text" id="owner" value="<%=rs("gsell")%>" onKeyDown="next()"></td>
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
viewaction=request("viewaction")
if viewaction="yes" then 
 if is_sku("Yname","Yuan_Info","'"&request("dname")&"'")=1 then 
  'sc "有该款式！"
  if is_sku("supplyID|Yname","yuan_supply_detail","'"&request("danno")&"'|'"&request("dname")&"'")=0 then 
  call dbdo(1,"yuan_supply_detail","supplyId|Yname|Yprice-'"&request("danno")&"'|'"&request("dname")&"'|"&request("dqyt"))
  else 
  sql="update yuan_supply_detail set Yprice="&request("dqyt")&" where supplyID='"&request("danno")&"' and Yname='"&request("dname")&"' "
  call dbdo(2,sql,sql)
  end if 
 else
 sc "该商品不存在！"
 end if 
end if 
if request.querystring("danno")<>"" then 
Cdanhao=request.querystring("danno")
end if 
set rs=server.createobject("adodb.recordset") 
sql="select * from yuan_supply_detail where supplyid='"&ID&"' "
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	    <form action="supply_yuan.asp?action=view&id=<%=id%>" method="POST" name="billd" id="billd">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6  class="optiontitle"> 单号：<%=id%> <input type="hidden" id="viewaction" name="viewaction" value="yes"> 
		  <input type="hidden" id="danno" name="danno" value="<%=ID%>"></td>
		</tr>
	    <tr bgcolor='#EBF0F7' align='center'>
		  <td>选中</td>
		  <td>供应商</td>
		  <td>原料</td>
		  <td>供应价</td>
		  <td>-</td>
		  <td>操作</td>
		</tr>
<%
rs.open sql,conn,1,1
if not rs.eof Then
for i = 1 to rs.recordcount
%>
	    <tr bgcolor='#FFFFFF' align='center'>
		  <td><input type="checkbox" name="id" value="<%=rs("id")%>"></td>
		  <td><%=rs("supplyid")%></td>
		  <td><%=rs("Yname")%></td>
		  <td><%=rs("Yprice")%></td>
		  <td></td>
		  <td><IMG src="../images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del2&id=<%=rs("id")%>&danno=<%=id%>&action=view')">删除</a></td>
		</tr>
<%
rs.movenext 
next 
%>
	    <tr bgcolor='#FFFFFF' align='center'>
		  <td colspan=2>原料类别：</td>
		  <td>金额:<input id="dqyt" name="dqyt" size="4" value="1"></td>
		  <td colspan=2><input id="dname" name="dname" style="width:100%" /></td>
		  <td><input type="Submit" name="Submit3" value="提交" ></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="6">
          <input type="button" name="Submit2" value="返回" onClick="history.back(-1)"></td>
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