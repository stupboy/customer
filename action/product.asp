<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<script src="../inc/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  $("#hide").click(function(){
  $("div.YLQK").hide();
  });
  $("#show").click(function(){
  $("div.YLQK").show();
  });
});
</script>
<%
id=Request("id")
'-删除记录 is_ok='false'-
if Request("wor")="del" then
 id=request("id")
 'sc id
 idArr=split(id,",")
 for i=0 to ubound(idArr)
  sql="update billInfo set is_ok='false' where id="&trim(idArr(i))
  conn.execute(sql)
  'sc sql
 next
elseif Request("wor")="del2" then
 id=request("id")
 idArr=split(id,",")
 for i=0 to ubound(idArr)
  sql="delete from billdetail where id="&trim(idArr(i))
  conn.execute(sql)
 next 
  id=request("danno")
  '-全部生产-
elseif Request("wor")="all" then
sql="update billdetail set ProductQty="&Request("Bqty")&" where id="&id
conn.execute(sql)
id=request("danno")
elseif Request("addon")="yes" then 
 sql="insert into billInfo (billno,status,cuser,billway,customer_id,billnote) values ('"&Request("billno")&"',0,'"&session("RealName")&"','下单','"&Request("rank")&"','"&request("comment")&"')"
 conn.execute(sql)
end if
'-更新订单信息状态 1变2 -
if Request("tj")="yes" then 
sql="update BillInfo set status=2 where id="&Request("id")
conn.execute(sql)
'-取消生产订单-
elseif Request("tj")="sb" then 
sql="update BillInfo set status=0,billnote='订单退回！' where id="&Request("id")
conn.execute(sql)
sql="update billdetail set ProductQty=0 where billno='"&Request("danno")&"'"
conn.execute(sql)
'-原料扣减-
elseif Request("tj")="yuan" then 
'-扣减标注-
sql="update BillInfo set YuanCut=1 where id="&Request("id")
conn.execute(sql)
'sc sql
'-获取关联数值-
'-查询对应生产订单中的商品及数量,将结果集转二维数组-
sql="select * from Billdetail where billno='"&Request("danno")&"'"
set rs=conn.execute(sql)
Tmpx=Rs.GetRows()
Tmp1s=ubound(Tmpx,2)
rs.close
set rs=nothing
'-生成原料单号-
Ydanhao=danhao("Y") '-避免变量i的冲突-
for ii = 0 to tmp1s '-循环计算该单据消耗原料-
 sql="select * from Goods_Yuan where Gname='"&tmpx(2,ii)&"'"
 set rs=conn.execute(sql)
 Tmp2=Rs.GetRows()
 Tmp2s=ubound(Tmp2,2)
 rs.close
 set rs=nothing
 for jj = 0 to tmp2s
  KK=0 '-初始化原料数量-
  '-订单数量乘以配发数量-
  KK=Cdbl(tmp2(3,jj))*Cdbl(tmpX(3,ii))*-1
  '-判断原单据是否存在记录,无则insert有则update-
  if is_sku("Yname|Ydanno","Yuan_store","'"&tmp2(2,jj)&"'|'"&Ydanhao&"'")=0 then 
  sql="insert into Yuan_store (Yname,yqty,yway,ydancat,ydanno,ynote,CreateUser) values ('"&tmp2(2,jj)&"',"&kk&",'生产','生产扣减','"&Ydanhao&"','"&Request("danno")&"','"&session("RealName")&"')"
  conn.execute(sql)
  else 
  sql="update Yuan_Store set Yqty=Yqty+"&kk&" where Yname='"&tmp2(2,jj)&"' and Ydanno='"&Ydanhao&"' "
  conn.execute(sql)
  end if 
 next
next 
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
if (confirm("按订单量生产！"))
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
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF">
<!--增加订单 及 订单列表-->
<%if action="list" then%>
  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="9"  class="optiontitle">提交生产订单</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
		  <td width="5%">选中</td>
          <td width="10%">单号</td>
          <td width="5%">数量|生产</td>
          <td width="5%">金额</td>
          <td width="5%">下单客户</td>
          <td width="5%">业务员</td>
		  <td width="5%">交货日期</td>
          <td width="16%">备注</td>
          <td width="10%">操作</td>
        </tr>	
<%
         '数据查询
         sql=" select a.*,b.数量,b.金额,c.RealName,b.数量1,b.金额1,d.realname Realname1 from billInfo a left join billdetail_sum b on a.billno=b.billno left join Customer c on a.customer_id=c.id left join Customer d on a.customer_id1=d.id where a.is_ok='TRUE' and a.status>0 and a.billway in ('下单','批发','定制') order by billno desc "
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
		  elseif rs("status")=1 and rs("数量1")=0 then 
		  sctd ztgs("已提交",4)
		  elseif rs("status")=1 and rs("数量1")=rs("数量") then 
	      sctd ztgs("生产完",4)
		  elseif rs("status")=1 and rs("数量1")>0 then 
		  sctd ztgs("生产中:"&(rs("数量1")*100/rs("数量"))&"%",4)
		  elseif rs("status")=2 then 
		  sctd ztgs("待入库",2)
		  elseif rs("status")=3 then 
		  sctd ztgs("已入库",1)
		  end if 
		  sctd1 rs("billno"),rs("billdate")
		  sctd rs("数量")&"|"&rs("数量1")
		  sctd rs("金额")
		  sctd rs("Realname1")
		  sctd rs("RealName")
		  sctd rs("Gdate")
		  sctd1 left(rs("billnote"),15),rs("billnote")
		  sc "<td>"
		  sc "<IMG src='../images/view.gif' align='absmiddle'><a href='?action=view&id="&rs("id")&"'>生产</a>"
          if rs("status")= 1 then 
		  sc "| <IMG src='../images/edit.gif' align='absmiddle'><a href='?action=list&tj=yes&id="&rs("id")&"'>发货</a>"&_
		  " | <IMG src='../images/drop.gif' align='absmiddle'>"&_
		  "<a href='?action=list&tj=sb&id="&rs("id")&"&danno="&rs("billno")&"'>取消</a>"
          elseif rs("status")=2 then 
		  sc "|"&ztgs("待入库",2)
		  elseif rs("status")=3 then 
		  sc "| "&ztgs("已入库",1)
		  if rs("YuanCut")=0 then 
		  sc "|<IMG src='../images/view.gif' align='absmiddle'><a href='?action=list&tj=yuan&id="&rs("id")&"&danno="&rs("billno")&"'>原料</a>"
		  end if 
		  end if
		  sc "</td>"		  
%>
          <!--<td><IMG src="../images/view.gif" align="absmiddle"><a href="?action=view&id=<%=rs("id")%>">生产</a><% if rs("status")= 1 then %>| <IMG src="../images/edit.gif" align="absmiddle"><a href="?action=list&tj=yes&id=<%=rs("id")%>">发货</a> | <IMG src="../images/drop.gif" align="absmiddle"><a href="?action=list&tj=sb&id=<%=rs("id")%>&danno=<%=rs("billno")%>">取消</a><% else %> | 已发货 <% end if %></td>-->
        </tr>
<%
rs.movenext 
next
%>
<!--
		<tr bgcolor="#F2FDFF">
		  <td colspan="9">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> 全选
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input name="tj" type="hidden" id="tj" value="yes" />
		   <input type="submit" name="Submit3" value="删除所选" onClick="{if(confirm('确定发货？发货后无法修改数量！')){return true;}return false;}" />
		  </td>
		</tr>
-->
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
  if is_sku("billno|goodsid","billdetail","'"&request("danno")&"'|'"&request("dname")&"'")=0 then 
  'call dbdo(1,"billdetail","billno|goodsid|billqyt|cuser-'"&request("danno")&"'|'"&request("dname")&"'|"&request("dqyt")&"|'"&session("RealName")&"'")
  sc "订单无这款商品！"
  else 
  sql="update billdetail set ProductQty=ProductQty +"&request("dqyt")&" where billno='"&request("danno")&"' and goodsid='"&request("dname")&"' "
  call dbdo(2,sql,sql)
  'sc sql
  end if 
 else
 sc "该商品不存在！"
 end if 
end if 
set rs=server.createobject("adodb.recordset") 
'sql="select * from billInfo where id="&Request("id")
sql="select * from billInfo where id="&id
rs.open sql,conn,1,1
if not rs.eof Then
%>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	    <form action="product.asp?action=view&id=<%=id%>" method="POST" name="billd" id="billd">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=4  class="optiontitle"> 单号：<%=rs("billno")%> <input type="hidden" id="viewaction" name="viewaction" value="yes"> 
		  <input type="hidden" id="danno" name="danno" value="<%=rs("billno")%>"></td>
		</tr>
	    <tr bgcolor='#EBF0F7' align='center'>
		  <td>选中</td>
		  <td>商品</td>
		  <td>数量|生产</td>
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
		  <td><%=rs2("billqyt")%>|<%=rs2("ProductQty")%></td>
		  <td><% if rs("status")= 1 then %><IMG src="../images/view.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=all&bqty=<%=rs2("billqyt")%>&id=<%=rs2("id")%>&danno=<%=id%>&action=view')">全部</a><% end if %></td>
		</tr>
<%
   rs2.movenext 
   next
   rs2.close
   set rs2=nothing
   end if
%>
<%
   if rs("status")= 1 then 
%>
	    <tr bgcolor='#FFFFFF' align='center'>
		  <td >输入商品：</td>
		  <td>数量:<input id="dqyt" name="dqyt" size="4" value="1"></td>
		  <td ><input id="dname" name="dname" style="width:100%" /></td>
		  <td><input type="Submit" name="Submit3" value="提交" ></td>
		</tr>
<%
end if 
end if 
%>
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=6 > 订单备注：<%=rs("BillNote")%></td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="4"><a href='?action=list'><u><strong><em>返回</em></strong></u></a></td>
		</tr>
		</form>
		<tr bgcolor='#EBF0F7' align='center'>
		  <td>原料名称</td>
		  <td>需求数量</td>
		  <td>库存数量</td>
		  <td>需求情况</td>
		</tr>
		<%
   sql2="select aa.GnameYuan,aa.Yuanqty,qty Storeqty from (select sum(b.GnameYuanQty*(billqyt-ProductQty)) Yuanqty,b.GnameYuan from BillDetail_Info a left join Goods_Yuan b on a.goodsid=b.Gname where status=1 and billway in ('下单','定制','批发','XNY') group by b.GnameYuan) aa left join (select a.Yname,sum(Yqty) qty from Yuan_Store a left join Yuan_Info b on a.Yname=b.Yname group by a.Yname) bb on aa.GnameYuan=bb.Yname "
   set rs2=server.createobject("adodb.recordset") 
   rs2.open sql2,conn,1,1
   if not rs.eof then
	 For i = 0 to rs2.recordcount
	 if rs2.eof then     
	 Exit For 
	 end if
	 
	 dim cysl
	 cysl=rs2("Storeqty")-rs2("Yuanqty")
%>
	    <tr bgcolor='#FFFFFF' align='center' class='YLQK'>
		  <td><%=rs2("GnameYuan")%></td>
		  <td><%=rs2("Yuanqty")%></td>
		  <td><%=rs2("Storeqty")%></td>
		  <td>
		  <% 	  
		  if cysl>=0 then 
		  sc ztgs("库存充足",1)
		  else
		  sc ztgs("库存不足",2)
		  end if 
		  %>
		  </td>
		</tr>
<%
   rs2.movenext 
   next
   rs2.close
   set rs2=nothing
   end if
%>
  	</table>
<%
end if
%>
</td>
</tr>
</table>
</body>
</html>