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
 case else
  response.redirect "action/error.asp"
end select 
%>