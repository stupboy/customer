<!--#include file="lib/lib.all.asp"-->
<%
'网站动作处理
dz=request.querystring("dz")
select case dz
 case "a001"
  response.redirect "action/goods.asp?action=list"
 case "a002"
  response.redirect "action/admin.asp?action=list"
 case "a003"
  response.redirect "action/bill.asp?action=list"
 case "a005"
  response.redirect "action/kehu.asp?action=list"
 case "a006"
  response.redirect "action/yuan.asp?action=list"
 case "a007"
  response.redirect "action/yuanS.asp?action=list"
 case "a009"
  response.redirect "action/Goods_yuan.asp?action=list"
 case "a010"
  response.redirect "action/Store.asp?action=Yuan"
 case "a011"
  response.redirect "action/product.asp?action=list"
 case "a012"
  if qx("C1",session("Limit")) then 
  response.redirect "action/Store.asp?action=goods"
  end if 
 case "a013"
  response.redirect "action/sell.asp?action=list"
 case "a015"
  response.redirect "action/Instore.asp?action=list"
 case "a016"
  response.redirect "action/Retail.asp?action=list"
 'case "a017"
  'response.redirect "action/Cai.asp?action=list"
 '-无其他动作返回错误页面-
 case else
  response.redirect "action/error.asp"
end select 
%>