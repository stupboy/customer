<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<%
id=Request("id")
'-删除记录 is_ok='false'-
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
 sql="insert into billInfo (billno,status,cuser,billway,customer_id,billnote) values ('"&Request("billno")&"',0,'"&session("RealName")&"','零售','"&Request("rank")&"','"&request("comment")&"')"
 conn.execute(sql)
end if
if Request("tj")="yes" then 
sql="update BillInfo set status=1 where id="&Request("id")
conn.execute(sql)
elseif Request("tj")="shou" then 
sql="update BillInfo set status=3 where id="&Request("id")
conn.execute(sql)
end if 
'-添加和修改记录 id为空则为添加 否则为修改-
'-获取传递变量-
action=Request("action")
addon=Request("addon")

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
</head>
<body>
<%
sc "<table width='100%' border='0' cellpadding='0' cellspacing='0'>"
sc "<tr valign='top'>"
sc "<td bgcolor='#FFFFFF'>"

if action="list" then

sc "<table width='96%'  border='0' align='center' cellpadding='4' cellspacing='1' bgcolor='#aec3de'>"
sc "<form name='add' method='post' action='retail.asp'>"
sc "<tr align='center' bgcolor='#F2FDFF'>"
sc "<td colspan='6'  class='optiontitle'> 客户销售单据 </td>"
sc "</tr>"
sc "<tr bgcolor='#F2FDFF'>"
sc "<td align='right' bgcolor='#F2FDFF'> 单号：</td>"
sc "<td colspan='5' bgcolor='#F2FDFF'><input name='billno' type='text' id='billno' value='"&danhao("L")&"' size='30' maxlength='50' readonly='readonly' >按回车\TAB键即可输入下一选项</td>"
sc "</tr>"	
sc "<tr bgcolor='#FFFFFF'>"
sc "<td align='right' bgcolor='#FFFFFF'> 零售客户：</td>"
sc "<td colspan='5' >"
'-数据查询-
sql="select * from Customer where is_ok='true' order by CustomerType "
set rs_kehu=conn.execute(sql)
'-select-
sc "<select name='rank' id='rank' selfvalue='客户级别'>"
sc "<option value=''>请选择</option>"
do while rs_kehu.eof=false
sc "<option value='"&rs_kehu("ID")&"'>"&rs_kehu("RealName")&",客户类型："&rs_kehu("CustomerType")&"类.</option>"
rs_kehu.movenext
loop
rs_kehu.close
set rs_kehu=nothing 
sc "</select>"
sc "</td>"
sc "</tr>"

sc "<tr bgcolor='#FFFFFF'>"
sc "<td align='right' bgcolor='#FFFFFF'> 备注：</td>"
sc "<td colspan='5'><textarea name='comment' cols='60' rows='5' id='comment' onKeyDown='next()'></textarea></td>"
sc "</tr>"
sc "<tr align='center' bgcolor='#ebf0f7'>"
sc "<td colspan='6' >"
sc "<INPUT TYPE='hidden' name='action' id='action' value='list' >"
sc "<INPUT TYPE='hidden' name='addon' id='addon' value='yes' >"
sc "<input type='submit' name='Submit' value='提交' onClick='check()'>"
sc "<input type='button' name='Submit2' value='返回' onClick='history.back(-1)'></td>"
sc "</tr>"
sc "</FORM>"
sc "</table>"
sc "<br>"


sc "<table width='96%'  border='0' align='center' cellpadding='4' cellspacing='1' bgcolor='#aec3de'>"
sc "<tr align='center' bgcolor='#F2FDFF'>"
sc "<td colspan='9'  class='optiontitle'>商品信息</td>"
sc "</tr>"
sc "<tr align='center' bgcolor='#ebf0f7'>"
sc "<td width='5%'>选中</td>"
sc "<td width='10%'>单号</td>"
sc "<td width='5%'>数量</td>"
sc "<td width='8%'>金额</td>"
sc "<td width='10%'>日期</td>"
sc "<td width='5%'>客户</td>"
sc "<td width='5%'>途径</td>"
sc "<td width='8%'>备注</td>"
sc "<td width='10%'>操作</td>"
sc "</tr>"	

 sql=" select a.*,b.数量,b.金额,c.RealName,b.数量1,b.金额1 from billInfo a left join billdetail_sum b on a.billno=b.billno left join Customer c on a.customer_id=c.id where a.is_ok='TRUE' and a.billway='零售' order by a.status,billno desc "
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
     '-数据循环输出 start-
	 sc "<form name='del' action='' method='post'>"
	 sc "<tr align='center' bgcolor='#FFFFFF' onmouseover=""this.style.background='#F2FDFF'"" onmouseout=""this.style.background='#FFFFFF'"">"
	 if rs("status")=0 then 
	 sctd "<input type='checkbox' name='id' value='"&rs("id")&"'>"
	 elseif rs("status")=1 then 
	 sctd "待入库"
	 elseif rs("status")=2 then 
	 sctd "待入库"
	 elseif rs("status")=3 then 
	 sctd "<IMG src='../images/rk.png' align='absmiddle'><strong><span style='color:#009900;background-color:#FFE500;'>已入库</span></strong>"
	 end if 
	 sctd rs("billno")
	 sctd rs("数量")
	 sctd rs("金额")
	 sctd rs("billdate")
	 sctd rs("RealName")
	 sctd rs("billway")
	 sctd rs("billnote")
	 sc "<td>"
	 sc "<IMG src='../images/view.gif' align='absmiddle'><a href='?action=view&id="&rs("id")&"'>查看</a>"
          if rs("status")= 0 then 
		  sc "| <IMG src='../images/edit.gif' align='absmiddle'><a href='?action=list&tj=yes&id="&rs("id")&"'>提交</a>"&_
		  " | <IMG src='../images/drop.gif' align='absmiddle'>"&_
		  "<a href=""javascript:DoEmpty('?wor=del&id="&rs("id")&"&action=list&ToPage="&intCurPage&"')"">删除</a>"
          elseif rs("status")=1 then 
		  sc "| 待入库"
		  elseif rs("status")=2 then 
		  sc "| <IMG src='../images/rk.png' align='absmiddle'>已入库"
		  elseif rs("status")=3 then 
		  sc "| 已入库"
		  'sc "| <IMG src='../images/edit.gif' align='absmiddle'><a href='?action=list&tj=shou&id="&rs("id")&"'>收货</a>"
		  end if
		  sc "</td>"
		  sc "</tr>"
		  '-数据循环输出 end-
		  
          rs.movenext 
          next
		  %>
		<tr bgcolor="#F2FDFF">
		  <td colspan="9">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> 全选
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="删除所选" onClick="{if(confirm('确定要删除记录吗？删除后将被无法恢复！')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="9">总共：
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
          <td colspan="9">对不起！目前数据库中还没有添加商品信息！</td>
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
 if is_sku("Gname","GoodsInfo","'"&request("dname")&"'")=1 then 
  'sc "有该款式！"
  if is_skux("goodsid|customer|数量1","WT_storedetail_sum","'"&request("dname")&"'|'"&request("cuname")&"'|"&request("dqyt"),"1|1|2")=1 then 
  'sc "'"&request("dname")&"'|'"&request("cuname")&"'|"&request("dqyt")
  'if is_sku("goodsid|customer","storedetail_sum","'"&request("dname")&"'|'"&request("cuname")&"'")=1 then 
   if is_sku("goodsid|billno","billdetail_info","'"&request("dname")&"'|'"&request("danno")&"'")=0 then 
   call dbdo(1,"billdetail","billno|goodsid|billqyt|cuser-'"&request("danno")&"'|'"&request("dname")&"'|"&request("dqyt")&"|'"&session("RealName")&"'")
   else
   sql="update billdetail set billqyt=billqyt +"&request("dqyt")&" where billno='"&request("danno")&"' and goodsid='"&request("dname")&"' "
   call dbdo(2,sql,sql)
   end if
  else
  SL=look_db("数量1","WT_storedetail_sum","customer|goodsid",request("cuname")&"|"&request("dname"))
  sc "该商品无库存或库存不足!现有库存"&SL&"件！" 
  end if 
 else
 sc "该商品不存在！"
 end if 
end if 
set rs=server.createobject("adodb.recordset") 
sql="select a.*,b.Realname,c.RealName Realname1 from billInfo a left join Customer b on a.customer_id=b.id left join Customer c on a.customer_id1=c.id where a.id="&id
'sql="select * from billInfo where id="&id
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	    <form action="retail.asp?action=view&id=<%=id%>" method="POST" name="billd" id="billd">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=4  class="optiontitle"> 单号：<%=rs("billno")%> <input type="hidden" id="viewaction" name="viewaction" value="yes"> 
		  <input type="hidden" id="danno" name="danno" value="<%=rs("billno")%>"></td>
		</tr>
	    <tr bgcolor='#EBF0F7' align='center'>
		  <td>选中</td>
		  <td>商品</td>
		  <td>数量</td>
		  <td>操作</td>
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
		  <td><%=rs2("billqyt")%></td>
		  <td><% if rs("status")= 0 then %><IMG src="../images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del2&id=<%=rs2("id")%>&danno=<%=id%>&action=view')">删除</a><% end if %></td>
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
		  <td >输入商品：</td>
		  <td>数量:<input id="dqyt" name="dqyt" size="4" value="1"></td>
		  <td ><input id="dname" name="dname" style="width:100%" /></td>
		  <td><input type="hidden" name="cuname" value="<%=rs("RealName")%>"><input type="Submit" name="Submit3" value="提交" ></td>
		</tr>
<%
end if 
%>
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6 > 订单备注：<%=rs("BillNote")%></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="4">
          <a href='?action=list'><u><strong><em>返回</em></strong></u></a>
          <!--<input type="button" name="Submit2" value="返回" onClick="history.back(-1)">--></td>
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